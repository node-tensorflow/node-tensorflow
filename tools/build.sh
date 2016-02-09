# Compile photobuf
cd "lib/tensorflow"
echo ""
echo "= Configuring TensorFlow (GPU: $TENSORFLOW_GPU_ENABLED)"
./configure <<< "n"
echo "= Compiling TensorFlow [cc|core]"
bazel build //tensorflow/cc:cc_ops //tensorflow/core:tensorflow

