var test = require('tape')
  , tensorflow = require('../index')

test('Tensorflow Version', function(t){
  t.equal(tensorflow.version, '0.6.0')
  t.end()
})
