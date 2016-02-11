cd "lib/tensorflow"
echo ""
git reset --hard
patch -Np1 < ../../tools/tensorflow.patch # From https://github.com/bytedeco/javacpp-presets/blob/master/tensorflow/tensorflow-master.patch
echo "\n" | ./configure
bazel build --verbose_failures=1 -c opt //tensorflow/cc:libtensorflow.so
#bazel build --verbose_failures=2 //tensorflow/cc:cc_ops //tensorflow/core:protos_all_cc //tensorflow/core:tensorflow

