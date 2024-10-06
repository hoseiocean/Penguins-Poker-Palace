//
//  Suit.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUICore


enum Suit: String, CaseIterable {
  case clubs = "clubs"
  case diamonds = "diamonds"
  case hearts = "hearts"
  case spades = "spades"
  
  var color: CardColor {
    switch self {
      case .clubs, .spades: return .black
      case .diamonds, .hearts: return .red
    }
  }
  
  var emoji: String {
    switch self {
      case .clubs: return "♣️"
      case .diamonds: return "♦️"
      case .hearts: return "❤️"
      case .spades: return "♠️"
    }
  }
  
  var name: String {
    rawValue
  }
  
  var symbol: String {
    switch self {
      case .clubs: return "♣"
      case .diamonds: return "♦"
      case .hearts: return "♥"
      case .spades: return "♠"
    }
  }
}
