#Nate Owen

#O(n) time complexity, O(n) space 
def reverseWords(str) 
  str.reverse!
  str.split.map{|word| word.reverse!}.join(" ")
end


#O(n) time complexity, O(1) space
def reverseWordsLite(str)
  str.reverse!
  wordStart, wordEnd = 0, 0
  str.each_char do |char|
    if char == " "
      reverseSubString(str, wordStart, wordEnd-1)
      wordStart = wordEnd + 1
    end
    wordEnd += 1
  end
  reverseSubString(str, wordStart, wordEnd-1)
  str
end

def reverseSubString(str, i, j)
  while i < j 
    str[i], str[j] = str[j], str[i]
    i += 1
    j -= 1
  end 
end
