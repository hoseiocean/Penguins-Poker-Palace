//
//  Rank.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


enum Rank: Int, CaseIterable {
  case two = 2, three, four, five, six, seven, eight, nine, ten
  case jack, queen, king, ace
  
  var name: String {
    switch self {
      case .two: "two"
      case .three: "three"
      case .four: "four"
      case .five: "five"
      case .six: "six"
      case .seven: "seven"
      case .eight: "eight"
      case .nine: "nine"
      case .ten: "ten"
      case .jack: "jack"
      case .queen: "queen"
      case .king: "king"
      case .ace: "ace"
    }
  }
  
  var symbol: String {
    switch self {
      case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten: String(rawValue)
      case .jack: "J"
      case .queen: "Q"
      case .king: "K"
      case .ace: "A"
    }
  }
}

extension Rank: Comparable {
  static func < (lhs: Rank, rhs: Rank) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
