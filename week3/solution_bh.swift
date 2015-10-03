//: Playground - noun: a place where people can play

import UIKit

var str = "Hello playground"

func reversePhrase(phrase: String) -> String {
    return phrase.componentsSeparatedByString(" ").reverse().joinWithSeparator(" ")
}

print(reversePhrase(str))
