#include <nan.h>
#include <memory>

#include "tensorflow/core/public/version.h"

using namespace v8;

NAN_METHOD(Version) {
  info.GetReturnValue().Set(
    Nan::New<String>(TF_VERSION_STRING).ToLocalChecked()
  );
  return;
}


NAN_MODULE_INIT(Init) {

  Nan::Set(target, Nan::New("version").ToLocalChecked(),
  Nan::GetFunction(Nan::New<FunctionTemplate>(Version)).ToLocalChecked());
}

NODE_MODULE(tensorflow, Init);
