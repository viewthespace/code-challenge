// Runtime: O(n)
// Memory: 0(1)

function wiggleSort(arr) {
  var alt = true;

  for(var i = 1; i < arr.length; i++) {
    if((alt && arr[i-1] > arr[i]) || (!alt && arr[i-1] < arr[i])) {
      var temp = arr[i]
      arr[i] = arr[i-1]
      arr[i-1] = temp
    }
    alt = !alt
  }

  return arr;
}
