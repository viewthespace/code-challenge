//
//  SongsAboutRain.swift
//  SwiftCodingChallengesTests
//
//  Created by Gino Wu on 6/10/18.
//  Copyright © 2018 sample. All rights reserved.
//

import XCTest

class SongsAboutRain: XCTestCase {

    func testSongAboutRain() {
        XCTAssertEqual(songAboutRain([1, 3, 4, 2, 3, 5, 4, 5]), 4)
        XCTAssertEqual(songAboutRain([5, 1, 1, 1, 2]), 3)
        XCTAssertEqual(songAboutRain([3, 1, 2, 1]), 1)
        XCTAssertEqual(songAboutRain([4, 1, 3, 2, 1]), 2)
        XCTAssertEqual(songAboutRain([1, 2, 3, 2, 1]), 0)
        XCTAssertEqual(songAboutRain([]), 0)
        XCTAssertEqual(songAboutRain([1]), 0)
        XCTAssertEqual(songAboutRain([5, 2, 2, 1, 2, 4, 2, 1, 3, 5]), 23)
    }


    func songAboutRain(_ input: [Int]) -> Int {
        var result = 0
        var inBetween: [Int] = []
        var currentPeak: Int?

        for(index, element) in input.enumerated() {
            if isPeak(input, currentIndex: index, currentPeak: currentPeak) {
                if currentPeak == nil {
                    currentPeak = element
                } else {
                    currentPeak = min(currentPeak!, element)
                    result = inBetween.reduce(result) { $0 + (currentPeak! - $1) }
                    currentPeak = element
                    inBetween.removeAll()
                }
            } else if currentPeak != nil {
                inBetween.append(element)
            }
        }
        return result
    }

    func isPeak(_ input: [Int], currentIndex: Int, currentPeak: Int?) -> Bool {
        return currentIndex + 1 == input.count ?
            isGreaterThanPrevious(currentIndex, input) :
            isGreaterThanNext(currentIndex, input) && isGreaterThanPrevious(currentIndex, input) && !hasMorePeak(index: currentIndex, input: input, peak: currentPeak)
    }

    func hasMorePeak(index: Int, input: [Int], peak: Int?) -> Bool {
        guard peak != nil else { return false }
        return input[index..<input.count].first(where: { $0 > input[index] }) != nil
    }
    var isGreaterThanPrevious: ((Int, [Int]) -> Bool) { return { $0 > 0 ? $1[$0 - 1] < $1[$0] : true } }
    var isGreaterThanNext: ((Int, [Int]) -> Bool) { return { $0 < $1.count ? $1[$0 + 1] < $1[$0] : true } }

}
