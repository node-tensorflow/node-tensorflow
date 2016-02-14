cd "lib/tensorflow"
echo ""
#git submodule update --init
git reset --hard
patch -Np1 < ../../tools/tensorflow.patch # From https://github.com/bytedeco/javacpp-presets/blob/master/tensorflow/tensorflow-master.patch
echo "\n" | ./configure

# Prebuild some deps 
bazel build --verbose_failures=1 @jpeg_archive//:jpeg
bazel build --verbose_failures=1 -c opt //tensorflow/cc:libtensorflow.so
bazel build --verbose_failures=1 google/protobuf
#bazel build --verbose_failures=2 //tensorflow/cc:cc_ops //tensorflow/core:protos_all_cc //tensorflow/core:tensorflow

#cd ./bazel-tensorflow/tensorflow
#protoc ./tensorflow/core/framework/*.proto --cpp_out .
#protoc ./tensorflow/core/**/*.proto --cpp_out .
