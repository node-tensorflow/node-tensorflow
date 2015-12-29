# Pull base image.
FROM ubuntu:14.04

# This docker image belongs to the community.
# This docker image has (or will have) more than one "maintainer", comment your information
# 
#
MAINTAINER node-tensorflow

ENV NODE_VER 4.2.2

# Default install
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget python-pip python-dev&& \
  rm -rf /var/lib/apt/lists/*

# Automatically reload
RUN echo 'export NVM_DIR="$HOME/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.bashrc;

# Install Node.js by nvm
RUN /bin/bash -c \
  'git clone https://github.com/creationix/nvm.git ~/.nvm && \
      cd ~/.nvm && git checkout `git describe --abbrev=0 v0.29.0` && \
        source ~/.nvm/nvm.sh && \
  nvm install $NODE_VER && \
  nvm alias default $NODE_VER && \
  # Install the npm packages below this line
  npm install -g node-gyp'

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer
# RUN git clone https://github.com/node-tensorflow/node-tensorflow.git
# RUN cd "node-tensorflow" && ls && git checkout 1.0.0

ADD ./tools tensorflow/tools
RUN ls && cd tensorflow && ls && cd tools && ls

RUN bash ./tensorflow/tools/install.sh

RUN \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ADD ./ tensorflow


# RUN cd tensorflow && npm install && node-gyp configure build

CMD ["bash"]
