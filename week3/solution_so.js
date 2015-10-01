/*
* Runtime: O(N)
* Space: O(1)
* 
*/
var reverseWords = function(str) {
  var swap = function(arr, i, j){
    var tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }
  var reverse = function(arr, start, end){
    for(var i = start; i < ((start + end + 1) >> 1); i++) {
      swap(arr, i, end - (i - start));
    }
  }
  var l = str.length;
  var left = 0;
  var right = l - 1;
  for(var i = 0; i < ((l + 1) >> 1); i++){
    swap(str, i, l - 1 - i);
    if(str[i] === ' '){
      reverse(str, left, i - 1);
      left = i + 1;
    }
    if(str[l -1 -i] === ' '){
      reverse(str, l - i, right);
      right = l - i - 2;
    }
  }
  reverse(str,left,right); 
};