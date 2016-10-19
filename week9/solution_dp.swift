func removeDupes(arr: [Int]) {
  var dict = [Int: Int]()
  arr.forEach { dict[$0] = dict[$0] != nil ? dict[$0]! + 1 : 1 }
  for (k,v) in dict {
    if v % 2 != 0 {
      print(k)
    }
  }
}

let arr = [3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5]
let arr2 = [1, 4, 2, 3, 1, 5, 2, 4, 3]

removeDupes(arr: arr)
removeDupes(arr: arr2)
