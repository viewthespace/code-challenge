//
//  SongsAboutRain.swift
//  SwiftCodingChallengesTests
//
//  Created by Gino Wu on 6/10/18.
//  Copyright © 2018 sample. All rights reserved.
//

/*
 # Songs About Rain

 Given a list of integers representing the crossectional elevations of a line,
 calculate the amount of water that would be caught after an infinite amount of
 rain assuming any rain that spills of the side does not build up


 ## example 1

 ### input
 ```javascript
 [ 1, 3, 4, 2, 3, 5, 4, 5 ]

 /*

 if this were land, this would look like:

 x x
 x  xxx
 xx xxxx
 xxxxxxx
 xxxxxxxx

 */
 ```

 ### output
 ```javascript
 4


 /*

 explanation:

 given this input list, the blocks marked with a '.' would be filled with water

 x.x
 x..xxx
 xx.xxxx
 xxxxxxx
 xxxxxxxx

 */
 ```


 */

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
    }

    func songAboutRain(_ input: [Int]) -> Int {
        var result = 0
        var inBetween: [Int] = []
        var currentPeak: Int?
        guard input.count > 1 else { return result }

        for(index, element) in input.enumerated() {
            if isPeak(input, currentIndex: index) && currentPeak == nil {
                currentPeak = element
            } else if isPeak(input, currentIndex: index) && currentPeak != nil {
                currentPeak = min(currentPeak!, element)
                result = inBetween.reduce(result) { $0 + (currentPeak! - $1) }
                currentPeak = element
                inBetween.removeAll()
            } else if !isPeak(input, currentIndex: index) && currentPeak != nil {
                inBetween.append(element)
            }
        }

        return result
    }

    func isPeak(_ input: [Int], currentIndex: Int) -> Bool {
        return currentIndex + 1 == input.count ? input[currentIndex - 1] < input[currentIndex] : input[currentIndex + 1] < input[currentIndex]
    }

    
}
