### Week 2 Coding Challenge - Wiggle Sort

Given an unsorted array of Integers, reorder them such that:

```
nums[0] <= nums[1] >= nums[2] <= nums[3]...
```

#### Example

Input:
```
[1,2,3,4,5,6]
```

Solution:
```
[1,6,2,5,3,4]
```

Another Solution:
```
[1,5,2,6,3,4]
```


The output of your solution should pass the wigglechecker (I think it works):

``` Javascript
function wigglechecker(nums){
  var prev, next;
  for(var i = 0; i < nums.length; i++){
    var num = nums[i];
    prev = nums[i - 1];
    next = nums[i + 1];
    if(i % 2 === 0){
      if(typeof prev === 'undefined') prev = Number.POSITIVE_INFINITY;
      if(typeof next === 'undefined') next = Number.POSITIVE_INFINITY;
      if(num > next || num > prev) return false;
    }else{
      if(typeof prev === 'undefined') prev = Number.NEGATIVE_INFINITY;
      if(typeof next === 'undefined') next = Number.NEGATIVE_INFINITY;
      if(num < next || num < prev) return false;
    }
  }
  return true;
}
```
