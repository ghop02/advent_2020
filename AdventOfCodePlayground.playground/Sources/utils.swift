import Foundation


extension String {

  public var rows: [String] {
    get {
      return self.split(separator: "\n").map { String($0) }
    }
  }
}
