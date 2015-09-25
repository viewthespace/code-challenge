//
//  WiggleSort.swift
//  WeekTwoCodingChallenge
//
//  Created by Nathaniel Linsky on 9/24/15.
//  Copyright © 2015 VTS. All rights reserved.
//

import Foundation


func wiggleSort(integers: [Int]) -> [Int] {
    let sortedIntegers = integers.sort()
    var resultingArray = [Int]()
    for index in 0...sortedIntegers.count/2-1 {
        let offset = index*2
        resultingArray.insert(sortedIntegers[index], atIndex: offset)
        resultingArray.insert(sortedIntegers[sortedIntegers.count-index-1], atIndex: offset+1)
    }
    if sortedIntegers.count % 2 != 0 {
        resultingArray.append(sortedIntegers[sortedIntegers.count/2])
    }
    return resultingArray
}