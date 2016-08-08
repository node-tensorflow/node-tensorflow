var test = require('tape')
  , tensorflow = require('../index')

test('Tensorflow Version', function(t){
  t.equal(tensorflow.version, '0.9.0')
  t.end()
})
