# Compile photobuf
cd "lib/tensorflow"
echo ""
echo "= Configuring TensorFlow (GPU: $TENSORFLOW_GPU_ENABLED)"
echo "\n" | ./configure
echo "= Compiling TensorFlow [cc|core]"
bazel build //tensorflow/cc:cc_ops //tensorflow/core:tensorflow

