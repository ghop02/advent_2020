import Foundation

func twoSum(targetValue: Int, numbers: [Int]) -> (a: Int, b: Int)? {
  var totalValue = 0

  var leftIndex = 0
  var rightIndex = numbers.endIndex - 1

  while leftIndex != rightIndex {
    totalValue = numbers[leftIndex] + numbers[rightIndex]

    if totalValue == targetValue {
      return (a: numbers[leftIndex], b: numbers[rightIndex])
    }
    if totalValue < targetValue {
      leftIndex += 1
    }
    if totalValue > targetValue {
      rightIndex -= 1
    }
    if leftIndex == rightIndex {
      return nil
    }
  }
  return nil
}


public func threeSum(targetValue: Int, numbers: [Int]) -> (a: Int, b: Int, c: Int)? {

  for (i, value) in numbers.enumerated() {

    var numberCopy = Array(numbers)
    numberCopy.remove(at: i)

    if let result = twoSum(targetValue: targetValue - value, numbers: numberCopy) {
      return (a: value, b: result.a, c: result.b)
    }
  }

  return nil
}
