/**
 * khanBox()
 * runtime: O( N )
 * memory: O( 2N )
 */
function khanBox(matrix) {
  var max = 1;
  var counter = {};
  for(var i = 0; i < matrix.length; i++) {
    var key = '';
    var keyI = '';
    for(var j = 0; j < matrix.length; j++) {
      key += matrix[i][j] + ':';
      keyI += (matrix[i][j] ^ 1) + ':';
    }
    counter[key] = (counter[key] || 0) + 1;
    counter[keyI] = (counter[keyI] || 0) + 1;
    if (counter[key] > max) max = counter[key];
    if (counter[keyI] > max) max = counter[keyI];
  }
  return max;
}


/**
 * khanBox Tests()
 * mocha
 */
var assert = require('assert');
describe('Khan Box', function() {
  
  it('works', function() {

    var matrix = [
      [0, 1, 1, 0],
      [1, 1, 0, 0],
      [1, 0, 0, 1],
      [1, 0, 1, 1]
    ]
    
    assert.equal(khanBox(matrix), 2)

    var matrix = [
      [1, 1, 0],
      [0, 1, 1],
      [0, 1, 0]
    ]  
    assert.equal(khanBox(matrix), 1)

    var matrix = [
      [0, 1, 0, 0, 0],
      [0, 1, 0, 0, 0],
      [0, 1, 0, 0, 0],
      [1, 0, 1, 1, 1],
      [1, 0, 1, 1, 1],
    ]
  
    assert.equal(khanBox(matrix), 5)

  });

});


