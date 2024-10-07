//
//  Suit.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUICore


enum Suit: String, CaseIterable {
  case clubs = "suit_clubs"
  case diamonds = "suit_diamonds"
  case hearts = "suit_hearts"
  case spades = "suit_spades"
  
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
    rawValue
  }
  
  var symbol: String {
    switch self {
      case .clubs: "♣"
      case .diamonds: "♦"
      case .hearts: "♥"
      case .spades: "♠"
    }
  }
}
