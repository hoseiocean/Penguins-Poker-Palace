//
//  HandRank.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


enum HandRank: Int {
  case highCard, pair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush
  
  static func evaluate(cards: [Card]) -> HandRank {
    .highCard
  }
}
