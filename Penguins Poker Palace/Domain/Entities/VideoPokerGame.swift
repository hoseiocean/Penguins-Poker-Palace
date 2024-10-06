//
//  VideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class VideoPokerGame {
  private var deck: Deck
  var currentHand: [Card] = []
  
  init(deck: Deck) {
    self.deck = deck
  }
  
  func dealHand() -> [Card] {
    currentHand = []
    for _ in 1...5 {
      if let card = deck.dealCard() {
        currentHand.append(card)
      }
    }
    return currentHand
  }
  
  func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
  }
}
