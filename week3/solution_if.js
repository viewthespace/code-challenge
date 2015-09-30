// Runtime: O(1)
// Memory: O(1)

var reverseSentence = function(sentence) {
  var word_start = 0;

  sentence = sentence.split('');
  sentence = reverseArray(sentence);

  for(var i = 0; i <= sentence.length; i++) {
    if(sentence[i] == ' ' || i == sentence.length) {
      sentence = reverseArray(sentence, word_start, i-1);
      word_start = i + 1;
    }
  }

  return sentence.join('');
}

var reverseArray = function(arr, begin, end) {
  if(begin == undefined)
    begin = 0
  if(end == undefined)
    end = arr.length - 1

  for(begin; begin < end; begin++, end--) {
    var temp = arr[begin];
    arr[begin] = arr[end];
    arr[end] = temp;
  }

  return arr;
}
