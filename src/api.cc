#include <nan.h>
#include <memory>
#include "tensorflow/core/public/tensor_c_api.h"
#include "tensorflow/core/lib/core/coding.h"
//#include "tensorflow/core/lib/core/errors.h"
#include "tensorflow/core/lib/core/stringpiece.h"
#include "tensorflow/core/lib/gtl/array_slice.h"
#include "tensorflow/core/platform/port.h"
#include "tensorflow/core/platform/protobuf.h"
//#include "tensorflow/core/public/session.h"
//#include "tensorflow/core/public/status.h"
//#include "tensorflow/core/public/tensor.h"
//#include "tensorflow/core/public/tensor_shape.h"
#include "tensorflow/core/public/version.h"

using namespace v8;

NAN_METHOD(Version) {
    printf("%s", TF_VERSION_STRING);
}

NAN_METHOD(Print) {
    printf("This is a sample Node.js addon\n");
}

NAN_MODULE_INIT(Init) {
    Nan::Set(target, Nan::New("print").ToLocalChecked(),
      Nan::GetFunction(Nan::New<FunctionTemplate>(Print)).ToLocalChecked());

    Nan::Set(target, Nan::New("version").ToLocalChecked(),
      Nan::GetFunction(Nan::New<FunctionTemplate>(Version)).ToLocalChecked());
}

NODE_MODULE(myaddon, Init);
