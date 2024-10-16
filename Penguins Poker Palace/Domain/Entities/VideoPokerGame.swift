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
  
  func placeBet(_ bet: Int) {
    guard currentPlayerData.totalPoints > 0 else { return }
    currentPlayerData.currentBet = min(max(bet, 1), currentPlayerData.totalPoints)
  }

  func pay() {
    guard let bet = currentPlayerData.currentBet, bet > 0 else { return }

    if currentPlayerData.totalPoints >= bet {
      currentPlayerData.totalPoints -= bet
    }
    
    resetForNewRound()
  }
  
  func finalizeHand() -> HandRank {
    let handRank = evaluateHand()
    
    currentPlayerData.totalPoints += handRank.winnings * (currentPlayerData.currentBet ?? 0)
    checkAndUpdateFirstWinningHandDateIfNeeded()
    checkAndUpdateBestHandIfNeeded(with: handRank)
    
    currentPlayerData.totalHandsPlayed += 1
    if handRank != .none {
      currentPlayerData.winningHands += 1
    }
    
    handState = .finalHand
    return handRank
  }
  
  private func checkAndUpdateBestHandIfNeeded(with handRank: HandRank) {
    let bestHand = currentPlayerData.bestHand ?? .none
    guard handRank > bestHand else { return }
    currentPlayerData.bestHand = handRank
    currentPlayerData.bestHandDate = Date()
  }
  
  private func checkAndUpdateFirstWinningHandDateIfNeeded() {
    guard currentPlayerData.firstWinningHandDate == nil else { return }
    currentPlayerData.firstWinningHandDate = Date()
  }
  
  func resetForNewRound() {
    handState = .initialHand
    deck.reset()
    currentHand = deck.drawCards(5)
  }
  
  func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
  }
  
  func getHandName() -> String {
    evaluateHand().name
  }
}
