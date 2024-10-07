//
//  HandRank.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


enum HandRank: Int {
  case highCard, pair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush
  
  var name: String {
    switch self {
      case .highCard: String(localized: "High Card")
      case .pair: String(localized: "Pair")
      case .twoPair: String(localized: "Two Pair")
      case .threeOfAKind: String(localized: "Three of a Kind")
      case .straight: String(localized: "Straight")
      case .flush: String(localized: "Flush")
      case .fullHouse: String(localized: "Full House")
      case .fourOfAKind: String(localized: "Four of a Kind")
      case .straightFlush: String(localized: "Straight Flush")
      case .royalFlush: String(localized: "Royal Flush")
    }
  }
  
  static func evaluate(cards: [Card]) -> HandRank {
    .highCard
  }
}
