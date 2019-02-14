function only_uniq_item(arr) {
  var stack = [];
  var arr_length = arr.length;
  for (var i=0; i < arr_length; i++) {
    if (stack[arr[i]]) {
      delete stack[arr[i]];
    } else {
      stack[arr[i]] = true;
    }
  }
  for(var uniqItem in stack) {
    return uniqItem;
  }
}

only_uniq_item(example);
