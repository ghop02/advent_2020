import Foundation

func parsePassports(_ input: String) -> [String] {
  let passports = input
    .replacingOccurrences(of: "\n\n", with: "-")
    .replacingOccurrences(of: "\n", with: " ")
    .split(separator: "-")
    .map { String($0) }

  return passports
}

let requiredPassportKeys = Set([
  "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"
])

typealias Passport = [String: String]

func parsePassport(_ passport: String) -> Passport {
  let split = passport.split(separator: " ").map { $0.split(separator: ":")}
  var data: Passport = [:]
  for row in split {
    data[String(row[0])] = String(row[1])
  }

  return data

}


func parseHeight(_ value: String) -> Bool {
  if value.suffix(2) == "cm" {
    return value.prefix(3) >= "150" && value.prefix(3) <= "193"
  }
  if value.suffix(2) == "in" {
    return value.prefix(2) >= "59" && value.prefix(2) <= "76"
  }
  return false
}

let validateFunctions: [String:(String) -> Bool] = [
  "byr": { $0 >= "1920" && $0 <= "2002" },
  "iyr": { $0 >= "2010" && $0 <= "2020" },
  "eyr": { $0 >= "2020" && $0 <= "2030" },
  "ecl": { ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains($0)},
  "pid": { $0.count == 9 && $0.range(of: #"[0-9]+"#, options: .regularExpression) != nil},
  "hcl": { $0.range(of: #"#[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]"#, options: .regularExpression) != nil },
  "hgt": parseHeight
]


func isValidPassport(_ passport: String) -> Bool {
  let passport = parsePassport(passport)
  let keys = passport.keys

  let missingKeys = requiredPassportKeys.subtracting(keys)
  if !missingKeys.isEmpty {
    return false
  }

  for (key, validateFunc) in validateFunctions {
    if !validateFunc(passport[key]!) {
      return false
    }
  }
  return true
}
