//
//  VideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


class VideoPokerGame {
  private var deck: Deck
  
  private(set) var currentHand: [Card]
  private(set) var handState: HandState
  
  var currentPlayerData: PlayerData
  
  init(deck: Deck, playerData: PlayerData, currentHand: [Card] = [], handState: HandState = .initialHand) {
    self.deck = deck
    self.currentHand = currentHand
    self.handState = handState
    self.currentPlayerData = playerData
  }
  
  @discardableResult
  func dealHand() -> [Card] {
    guard handState == .initialHand else { return currentHand }
    currentHand = deck.drawCards(5)
    return currentHand
  }
  
  func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
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

  func finalizeHand() -> HandRank {
    let handRank = evaluateHand()
    
    currentPlayerData.totalPoints += handRank.winnings * (currentPlayerData.currentBet ?? 0)
    if let bestHand = currentPlayerData.bestHand, handRank > bestHand {
      currentPlayerData.bestHand = handRank
      currentPlayerData.bestHandDate = Date()
    }
    currentPlayerData.totalHandsPlayed += 1
    if handRank != .none {
      currentPlayerData.winningHands += 1
    }
    
    handState = .finalHand
    
    return handRank
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
