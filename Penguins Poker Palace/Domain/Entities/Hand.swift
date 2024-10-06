//
//  Hand.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


struct Hand {
  var cards: [Card]
  
  func evaluate() -> HandRank {
    HandRank.evaluate(cards: cards)
  }
}
