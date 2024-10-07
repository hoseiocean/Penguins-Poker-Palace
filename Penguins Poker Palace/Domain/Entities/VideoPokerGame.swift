//
//  VideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class VideoPokerGame {
  private var deck: Deck
  private var handState: HandState

  private(set) var currentHand: [Card]

  init(deck: Deck, currentHand: [Card] = [], handState: HandState = .initialHand) {
    self.deck = deck
    self.currentHand = currentHand
    self.handState = handState
  }
  
  func dealHand() -> [Card] {
    guard handState == .initialHand else { return currentHand }
    currentHand = deck.drawCards(5)
    return currentHand
  }
  
  func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
  }
  
  func exchangeCards(indices: [Int]) -> [Card] {
    guard handState == .initialHand else { return currentHand }
    indices.forEach { index in
      if let newCard = deck.dealCard() {
        currentHand[index] = newCard
      }
    }
    
    handState = .finalHand
    return currentHand
  }
  
  func resetGame() {
    deck.reset()
    handState = .initialHand
    currentHand = dealHand()
  }

}
