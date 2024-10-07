//
//  VideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class VideoPokerGame {
  private var deck: Deck
  private(set) var currentHand: [Card]
  private(set) var handState: HandState
  
  init(deck: Deck, currentHand: [Card] = [], handState: HandState = .initialHand) {
    self.deck = deck
    self.currentHand = currentHand
    self.handState = handState
  }
  
  @discardableResult
  func dealHand() -> [Card] {
    guard handState == .initialHand else { return currentHand }
    currentHand = deck.drawCards(5)
    return currentHand
  }
  
  @discardableResult
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
  
  func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
  }
  
  func getHandName() -> String {
    evaluateHand().name
  }
  
  func resetForNewRound() {
    handState = .initialHand
    deck.reset()
    currentHand = deck.drawCards(5)
  }
}
