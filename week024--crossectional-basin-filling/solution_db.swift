import Foundation

func water(in elevations: [Int]) -> Int {
    guard !elevations.isEmpty else { return 0 }
    var waterLevels = Array(repeating: 0, count: elevations.count)
    var sortedElevations = elevations.enumerated().sorted { $0.element > $1.element }

    for index in 1..<sortedElevations.count {
        let minimumWaterLevel = sortedElevations[index].element
        let peakIndices = [sortedElevations[index].offset, sortedElevations[index-1].offset].sorted()
        let waterRange = peakIndices[0]+1..<peakIndices[1]
        for waterIndex in waterRange {
            waterLevels[waterIndex] = max(waterLevels[waterIndex], minimumWaterLevel)
        }
    }

    return zip(waterLevels, elevations).map { max($0 - $1, 0) }.reduce(0) { $0 + $1 }
}

water(in: [ 1, 3, 4, 2, 3, 5, 4, 5 ]) // 4
water(in: [5, 2, 2, 1, 2, 4, 2, 1, 3, 5]) // 23
water(in: []) // 0
