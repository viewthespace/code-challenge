//: Playground - noun: a place where people can play
import UIKit

enum Flag {
    case Min
    case Max
    
    mutating func toggle() {
        switch self {
        case .Min: self = .Max
        case .Max: self = .Min
        }
    }
}

func wiggleSort(var input: [Int]) -> [Int] {
    var result = [Int]()
    input.sortInPlace()
    
    var flag = Flag.Min
    while input.count > 0 {
        result.append(flag == .Min ? input.removeFirst() : input.removeLast())
        flag.toggle()
    }
    
    return result
}


wiggleSort([1,2,3,4,5,6])