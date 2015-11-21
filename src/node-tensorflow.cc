#include <nan.h>

using namespace v8;

NAN_METHOD(Print) {
    printf("This is a sample Node.js addon\n");
}

NAN_MODULE_INIT(Init) {
    Nan::Set(target, Nan::New("print").ToLocalChecked(),
      Nan::GetFunction(Nan::New<FunctionTemplate>(Print)).ToLocalChecked());
}

NODE_MODULE(myaddon, Init);
