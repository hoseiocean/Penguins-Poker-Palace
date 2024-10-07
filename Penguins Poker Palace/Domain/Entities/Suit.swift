//
//  Suit.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUICore


enum Suit: String, CaseIterable {
  case clubs = "Clubs"
  case diamonds = "Diamonds"
  case hearts = "Hearts"
  case spades = "Spades"
  
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
