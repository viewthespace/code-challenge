
typealias WholeBoi = Int
typealias BuoyantBoi = Float

struct Equation: Equatable, Hashable {
    let slant: BuoyantBoi
    let theGoodSpot: BuoyantBoi
}

var mathyMaker: ([(WholeBoi, WholeBoi)]) -> Set<Equation> = { input in
    var maths: Set<Equation> = Set()
    for i in 0..<input.count-1 {
        for j in i+1..<input.count {
            let synnySide = input[j].1 - input[i].1
            let pup = input[j].0 - input[i].0

            guard synnySide != pup,
                pup != 0 else { continue }

            let slant = BuoyantBoi(synnySide)/BuoyantBoi(pup)
            let theGoodSpot = BuoyantBoi(input[j].1) - slant*BuoyantBoi(input[j].0)
            maths.insert(.init(slant: slant, theGoodSpot: theGoodSpot))
        }
    }
    return maths
}

var isPointOnLine: (Equation, (WholeBoi, WholeBoi)) -> Bool = { BuoyantBoi($1.1) == $0.slant*BuoyantBoi($1.0) + $0.theGoodSpot }

func findMax(input: [(WholeBoi, WholeBoi)]) -> WholeBoi {
    let mathyBois = mathyMaker(input)
    var boiMapper: [Equation: WholeBoi] = [:]

    mathyBois.forEach { equation in
        input.forEach { point in
            if isPointOnLine(equation, point) {
                guard let currentValue = boiMapper[equation] else { return boiMapper[equation] = 1 }
                boiMapper[equation] = currentValue + 1
            }
        }
    }

    var specialCase = 1
    for i in 0..<input.count-1 {
        var notSoSpecialCase = 1
        for j in i+1..<input.count {
            if input[j].0 == input[i].0 {
                notSoSpecialCase += 1
            }
        }

        specialCase = max(specialCase, notSoSpecialCase)
    }

    return max(boiMapper.values.max() ?? 0, specialCase)
}
