import Foundation


let input = "The sky is blue"

let oddInput = "Reverse this odd word sentence"


//Runtime O(Noob)
//Memory O(Noob)
//Where O(Noob) = O(n)
func reverseWords(input: String) -> String {
    var words = input.componentsSeparatedByString(" ")
    for var i = 0; i < words.count / 2; i++ {
        let tempWord = words[words.count - 1 - i]
        words[words.count - 1 - i] = words[i]
        words[i] = tempWord
    }
    return String(words)
}
