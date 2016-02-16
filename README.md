# TensorFlow.js

[![build status](https://travis-ci.org/node-tensorflow/node-tensorflow.svg)](https://travis-ci.org/node-tensorflow/node-tensorflow)

Node-tensorflow is a NodeJS API for utilizing Google's open-source machine learning library TensorFlow.
This project aims to allow more people easy-to-use access to the TensorFlow library inside of NodeJS while still having performance and stability in mind. The project is in early design stage and we appreciate anyone who would like to help!

## Contributing
We currently need all help we can get. We are specially looking for people with C++ knowledge!
For more information, please join the slack conversation.
https://tensor-flow-talk-invite.herokuapp.com/

## Get Started

There is a proof of idea of using SWIG interface. A simple test is made for checking the version of Tensorflow.
```
$ npm run _preinstall
$ npm install
$ npm test

# Tensorflow Version
ok 1 should be equal

1..1
# tests 1
# pass  1

# ok
```

## Current Progress

In our first proposal, we have defined the roadmap of building a Node.js API to utilize the core functions of Tensorflow. In order to control the graph execution from C++, we have to use Python API to build the computation graph and load the graph using C++ Session API. We are currently working on the Tensorflow interface using SWIG first which drives the C++ core API to a Node.js binding. Python API also provides Optimizers, Tensor Transformations, Type Casting, and some other useful features. We will have further discussion once the interface is built.

### Roadmap:

+ In progress

C++ core library <-> SWIG <-> Node.js binding <-> Python API <-> End Users

+ Final stage:

C++ core library <-> SWIG <-> Node.js binding <-> Node.js API <-> End Users

## Discussion of interface for different languages

+ [C# API](https://github.com/tensorflow/tensorflow/issues/18)
+ [Node.js API](https://github.com/tensorflow/tensorflow/issues/37)
+ [GoLang Library](https://groups.google.com/a/tensorflow.org/d/topic/discuss/GMd-Am_u9KE/discussion)
+ [Ruby API](https://github.com/tensorflow/tensorflow/issues/50)
+ [Rust API](https://github.com/tensorflow/tensorflow/issues/388)
+ [Swig to Java](https://github.com/tensorflow/tensorflow/issues/5)
