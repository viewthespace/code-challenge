/*
* Depends on how range of string is implemented, but it's not O(N) for sure
* Space: O(1)
* 
*/
import UIKit

func reverseWords(var input: String) -> String {
    var output = ""
    while input.characters.count > 0 {
        let lastCharacter = input.removeAtIndex(input.endIndex.predecessor())
        if lastCharacter == " " {
            output = "\(output)\(lastCharacter)"
        } else if let indexOfLastWhitespaceCharacter = output.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch)?.endIndex {
            output.insert(lastCharacter, atIndex: indexOfLastWhitespaceCharacter)
        } else {
            output = "\(lastCharacter)\(output)"
        }
    }
    
    return output
}

reverseWords("my name is Julian")
