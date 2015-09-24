// Runetime: O(n)
// Memory: O(1)
var wiggleSort = function(nums) {
  for(var i = 0; i < nums.length - 1; i++){
    var num = nums[i];
    var next = nums[i+1];
    if((i % 2 === 0 && num > next) || (i % 2 === 1 && num < next)) {
      nums[i] = next;
      nums[i+1] = num;
    }
  }
  return nums;
}