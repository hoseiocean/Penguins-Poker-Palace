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
      case .two: String(localized: "rank_name_two")
      case .three: String(localized: "rank_name_three")
      case .four: String(localized: "rank_name_four")
      case .five: String(localized: "rank_name_five")
      case .six: String(localized: "rank_name_six")
      case .seven: String(localized: "rank_name_seven")
      case .eight: String(localized: "rank_name_eight")
      case .nine: String(localized: "rank_name_nine")
      case .ten: String(localized: "rank_name_ten")
      case .jack: String(localized: "rank_name_jack")
      case .queen: String(localized: "rank_name_queen")
      case .king: String(localized: "rank_name_king")
      case .ace: String(localized: "rank_name_ace")
    }
  }
  
  var symbol: String {
    switch self {
      case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten: String(rawValue)
      case .jack: String(localized: "rank_symbol_j")
      case .queen: String(localized: "rank_symbol_q")
      case .king: String(localized: "rank_symbol_k")
      case .ace: String(localized: "rank_symbol_a")
    }
  }
  
  func isImmediatlyFollowedBy(_ other: Rank) -> Bool {
    other.rawValue == self.rawValue + 1
  }
}

extension Rank: Comparable {
  static func < (lhs: Rank, rhs: Rank) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
