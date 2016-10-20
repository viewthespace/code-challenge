function ht(nums) {
  var counter = 0;
  nums.forEach( num => counter ^= num );
  return counter;
}

var assert = require('assert');
var nums = [3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5];
assert.equal(ht(nums), 8)
var nums = [6, 6, 9, 7, 0, 0, 9];
assert.equal(ht(nums), 7)