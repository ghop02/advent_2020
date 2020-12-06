import Foundation


struct Seat: Hashable {
  let row: Int
  let column: Int

  var id: Int {
    get {
      return row * 8 + column
    }
  }
}



func getSeat(_ input: String) -> Seat {

  let binaryRow = input.prefix(7)
    .replacingOccurrences(of: "F", with: "0")
    .replacingOccurrences(of: "B", with: "1")
  let binaryColumn = input.suffix(3)
    .replacingOccurrences(of: "L", with: "0")
    .replacingOccurrences(of: "R", with: "1")

  return Seat(row: Int(binaryRow, radix: 2)!, column: Int(binaryColumn, radix: 2)!)
}



func getMaxSeatId(_ seats: [Seat]) -> Int {
  var maxVal = 0

  for seat in seats {
    if seat.id > maxVal {
      maxVal = seat.id
    }
  }
  return maxVal
}


func getMissingSeat(_ seats: [Seat]) -> Seat {
  var seatsByRow = [Int:[Seat]]()

  for seat in seats {
    var seats = seatsByRow[seat.row]
    if seats == nil {
      seats = [Seat]()
    }
    seats!.append(seat)
    seatsByRow[seat.row] = seats
  }
  for (row, seats) in seatsByRow {
    if row == 72 {
      print(row, seats)
    }
  }

  return Seat(row: 72, column: 3)
}

