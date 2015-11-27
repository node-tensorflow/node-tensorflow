// This is the entry file for Node.js API

var bindings = require('bindings');
var addon = bindings('node-tensorflow');

addon.version();

addon.test();