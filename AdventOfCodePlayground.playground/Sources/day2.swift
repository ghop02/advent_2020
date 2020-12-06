import Foundation


struct PasswordInfo {
  let reqs: (Int, Int)
  let letter: Character
  let password: String
}

func parseRow(line: String) -> PasswordInfo {
  let results = line.split(separator: " ")
  let minMax = results[0].split(separator: "-").map { String($0) }
  let (min, max) = (Int(minMax[0])!, Int(minMax[1])!)

  let letter: Character = Array(results[1])[0]
  let password = String(results[2])
  return PasswordInfo(reqs: (min, max), letter: letter, password: password)
}

let passwords = """
""".split(separator: "\n").map { String($0) }.map(parseRow)


func isValid(passwordInfo: PasswordInfo) -> Bool {
  let numMatching = passwordInfo.password.filter { $0 == passwordInfo.letter}.count
  return (numMatching >= passwordInfo.reqs.0) && (numMatching <= passwordInfo.reqs.1)
}

func isValid2(passwordInfo: PasswordInfo) -> Bool {
  let numMatching = passwordInfo.password.filter { $0 == passwordInfo.letter}.count

  let characters = Array(passwordInfo.password)
  let first = characters[passwordInfo.reqs.0 - 1] == passwordInfo.letter
  let second = characters[passwordInfo.reqs.1 - 1] == passwordInfo.letter
  return first != second
  return (numMatching >= passwordInfo.reqs.0) && (numMatching <= passwordInfo.reqs.1)
}
