//
//  Suit.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUICore


enum Suit: CaseIterable {
  case clubs
  case diamonds
  case hearts
  case spades

  var color: CardColor {
    switch self {
      case .clubs, .spades: .black
      case .diamonds, .hearts: .red
    }
  }
  
  var emoji: String {
    switch self {
      case .clubs: "♣️"
      case .diamonds: "♦️"
      case .hearts: "❤️"
      case .spades: "♠️"
    }
  }
  
  var name: String {
    switch self {
      case .clubs: String(localized: String.LocalizationValue("suit_clubs"))
      case .diamonds: String(localized: String.LocalizationValue("suit_diamonds"))
      case .hearts: String(localized: String.LocalizationValue("suit_hearts"))
      case .spades: String(localized: String.LocalizationValue("suit_spades"))
    }
  }
}
