//
//  VideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class VideoPokerGame {
  private var deck: Deck
  private(set) var currentHand: [Card] = []
  
  init(deck: Deck) {
    self.deck = deck
  }
  
  func dealHand() -> [Card] {
    currentHand = deck.drawCards(5)
    return currentHand
  }
  
  func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
  }
  
  func exchangeCards(indices: [Int]) -> [Card] {
    indices.forEach { index in
      if let newCard = deck.dealCard() {
        currentHand[index] = newCard
      }
    }
    return currentHand
  }
  
  func resetGame() {
    deck.reset()
    currentHand = dealHand()
  }

}
