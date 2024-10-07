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
      case .two: String(localized: "Two")
      case .three: String(localized: "Three")
      case .four: String(localized: "Four")
      case .five: String(localized: "Five")
      case .six: String(localized: "Six")
      case .seven: String(localized: "Seven")
      case .eight: String(localized: "Eight")
      case .nine: String(localized: "Nine")
      case .ten: String(localized: "Ten")
      case .jack: String(localized: "Jack")
      case .queen: String(localized: "Queen")
      case .king: String(localized: "King")
      case .ace: String(localized: "Ace")
    }
  }
  
  var symbol: String {
    switch self {
      case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten: String(rawValue)
      case .jack: String(localized: "J")
      case .queen: String(localized: "Q")
      case .king: String(localized: "K")
      case .ace: String(localized: "A")
    }
  }
}

extension Rank: Comparable {
  static func < (lhs: Rank, rhs: Rank) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
