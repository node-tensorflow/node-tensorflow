#!/bin/sh

# Global Configurations
TENSORFLOW_GPU_ENABLED="n"

# Change dir to shell script dir
cd $(dirname $0)

# Check current Platform
platform="linux"

if [ "$(uname)" == "Darwin" ]; then
	platform="darwin" # Mac OSX
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	platform="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	platform="windows"
fi

# 
# Package URL Source codes
# 

# pkg-config
PKG_CONFIG="http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz"

# Bazel Source
BAZEL_ROOT="https://github.com/bazelbuild/bazel/releases/download"
BAZEL_VERS="0.1.1"
PKG_BAZEL="$BAZEL_ROOT/$BAZEL_VERS/bazel-$BAZEL_VERS-installer-$platform-x86_64.sh"

# TensorFlow source
TENSORFLOW="https://github.com/tensorflow/tensorflow"

PREFIX=${1-/usr/local}

echo "=== Installing TensorFlow for $platform ==="

require() {
	if test `which $1`; then
		echo "= $1: Found"
	else
		echo "= $1: Not found"
		exit 1
	fi
}

install_shell() {
	local url=$1
	local name=`basename $url`

	echo ""
	echo "= Installing $name" \
	 && echo "== Downloading $name" \
	 && curl -# -L $url -o $name \
	 && echo "== Changing file to execute mode..." \
	 && chmod +x $name \
	 || exit 1

 	echo "== Installing..."
	if ./$name --user; then

		rm $name
	 	echo "== Sucessfully installed $name"

	else

	 	echo "! Failed to install $name"
	 	rm $name
	 	exit 1

	fi

}

fetch() {
	local tarball=`basename $1`
	local dir=`basename $tarball .tar.gz`

	echo ""
	echo "= downloading $tarball"
	curl -# -L $1 -o $tarball \
		&& echo "== unpacking" \
		&& tar -zxf $tarball \
		&& echo "== removing tarball" \
		&& rm -fr $tarball \
		&& make_install $dir
}

fetch_xz() {
	local tarball=`basename $1`
	local dir=`basename $tarball .tar.xz`

	echo ""
	echo "= downloading $tarball"
	
	curl -# -L $1 -o $tarball \
		&& echo "== unpacking" \
		&& tar -xJf $tarball \
		&& echo "== removing tarball" \
		&& rm -fr $tarball \
		&& make_install $dir
}

clone(){
	local repo=$1
	local folderName=$2

	echo ""
	echo "= cloning $repo"

	git clone --recurse-submodules $repo ./$folderName
}

make_install() {
	local dir=$1

	echo ""
	echo "= installing $1"

 	cd $dir \
	 && ./configure --disable-dependency-tracking --prefix=$PREFIX \
	 && make \
	 && make install \
	 && echo "... removing $dir" \
	 && cd .. && rm -fr $dir
}

install(){
	# Target OS to install
	local os=$1
	# Name of the package
	local name=$2

	# Check if is target OS
	if [ "$platform" != "$os" ]; then
		echo "= $name skipped (not in $os)"
		return
	fi

	# Check if package already installed
	if hash $name 2>/dev/null; then
		echo "= $name already installed"
		return
	fi

	if [ "$platform" == "linux" ]; then

		# Install for Linux
		if hash apt-get 2>/dev/null; then
			echo  ""
			echo "= installing with apt-get: $name"

			apt-get install $name -y
		else
			echo "! apt-get not installed"
			exit 1
		fi
	elif [ "$platform" == "darwin" ]; then
		
		# Install for Mac OSX
		if hash brew 2>/dev/null; then
			echo ""
			echo "= installing with brew: $name"

			brew install $name -y
		else
			echo "! brew not installed"
			exit 1
		fi
	fi
}

echo ""
echo "= installing to $PREFIX"

# Check for JDK 8
JAVA_VER=$(javac -version 2>&1 | sed 's/javac \(.*\)\.\(.*\)\..*/\1\2/; 1q')

if [ "$JAVA_VER" != "18" ]; then
	echo "JAVAC version is not 1.8. Current version: $JAVA_VER"
	exit 1
fi

# Check for dependencies that needs to be installed
require git
require curl
require javac

# Check for pkg-config and install if needed
test `which pkg-config` || fetch $PKG_CONFIG
require 'pkg-config'

# Install Bazel Dependencies
install linux "zip"
install linux "g++"
install linux "zlib1g-dev"
install linux "unzip"

# Install protobuf dependencies
install linux "dh-autoreconf"
install darwin "automake"

# 
# Install JDK 8, ONLY if JDK (javac) is not installed
# 
test `which javac` || install linux "oracle-java8-installer"

# 
# Install Bazel
# 
# Export path if not yet saved
if [[ ! ":$PATH:" == *":$HOME/bin:"* ]]; then
	echo '' >> ~/.bash_profile
	echo '# Required by Bazel' >> ~/.bash_profile
	echo 'export PATH=$PATH:'"$HOME/bin" >> ~/.bash_profile

	echo "= Saved $HOME/bin to ~/.bash_profile"
fi
# Do installation (check before)
export PATH="$PATH:$HOME/bin"

if hash bazel 2>/dev/null; then
	echo "= Bazel already installed"
else
	install_shell $PKG_BAZEL
fi

# 
# Install TensorFlow
# 

# Clone Repo
rm -rf "tensorflow"
clone $TENSORFLOW "tensorflow"
cd "tensorflow"

# Configure TensorFlow (with/without GPU)
echo ""
echo "= Configuring TensorFlow (GPU: $TENSORFLOW_GPU_ENABLED)"
./configure <<< "n"

# Compile TensorFlow CC
echo ""
echo "= Compiling TensorFlow:core"
bazel build //tensorflow/core


# Compile photobuf
cd "google/protobuf"
echo ""
echo "= Compiling Google's protobuf"
./autogen.sh
make
bazel build

echo ""
echo "= Finished!"
echo ""