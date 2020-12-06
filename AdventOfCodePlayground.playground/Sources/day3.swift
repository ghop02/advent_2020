import Foundation


public let X_INCREMENT = 3
public let Y_INCREMENT = 1

public struct Point {
  var x: Int
  var y: Int

}

public struct TobagganIndexer {
  let width: Int
  let xIncrement: Int
  let yIncrement: Int

  private var x = 0
  private var y = 0

  public init(width: Int, xIncrement: Int = X_INCREMENT, yIncrement: Int = Y_INCREMENT) {
    self.width = width
    self.xIncrement = xIncrement
    self.yIncrement = yIncrement
  }

  public var point: Point {
    get {
      return Point(x: x, y: y)
    }
  }

  public mutating func next() -> Point {
    self.x = (x + xIncrement) % width
    self.y = y + yIncrement
    return Point(x: x, y: y)
  }
}


public enum MapObject: Character {
  case TREE = "#"
  case OPEN_SQUARE = "."
}

public class TreeIndexer {

  private let map: [[MapObject]]

  public init(input: String) {
    self.map = input.split(separator: "\n").map { $0.map { MapObject(rawValue: $0)! }}
  }

  public subscript(index: Point) -> MapObject {
    get {
      return map[index.y][index.x]
    }
  }

  public var width: Int {
    // must have at least one row
    return map[0].count
  }
  public var rows: Int {
    get {
      return map.count
    }
  }
}


public func countTrees(inputMap: String, xIncrement: Int, yIncrement: Int) -> Int {
  let trees = TreeIndexer(input: inputMap)
  var indexer = TobagganIndexer(width: trees.width, xIncrement: xIncrement, yIncrement: yIncrement)

  var totalTrees = 0
  var point = indexer.point

  for _ in stride(from: 0, to: trees.rows, by: yIncrement) {
    totalTrees += trees[point] == .TREE ? 1 : 0
    point = indexer.next()
  }

  return totalTrees
}


public func runDay3(input: String, increments: [(Int, Int)]) {
  var total = 1
  for (xIncrement, yIncrement) in increments {
    total = total * countTrees(inputMap: input, xIncrement: xIncrement, yIncrement: yIncrement)
  }
  print(total)
}
