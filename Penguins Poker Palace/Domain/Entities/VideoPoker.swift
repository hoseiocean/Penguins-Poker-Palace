//
//  VideoPoker.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


class VideoPoker {
  private var deck: Deck
  private var videoPokerStateManager: VideoPokerStateManager

  private(set) var currentHand: [Card] = []
  private(set) var winnings: Int = 0

  var currentPlayerData: PlayerData
  
  var handState: HandState {
    videoPokerStateManager.currentState
  }

  init(deck: Deck, playerData: PlayerData, videoPokerStateManager: VideoPokerStateManager) {
    self.deck = deck
    self.videoPokerStateManager = videoPokerStateManager
    self.currentPlayerData = playerData
  }
  
  private func checkAndUpdateBestHandIfNeeded(with handRank: HandRank) {
    updatePlayerData(currentValue: &currentPlayerData.bestHand, newValue: handRank, dateKeyPath: \.bestHandDate)
  }
  
  private func checkAndUpdateBiggestWin() {
    updatePlayerData(currentValue: &currentPlayerData.biggestWin, newValue: winnings, dateKeyPath: \.biggestWinDate)
  }
  
  private func checkAndUpdateFirstWinningHandDateIfNeeded() {
    guard currentPlayerData.firstWinningHandDate != nil else { return }
    updatePlayerData(currentValue: &currentPlayerData.firstWinningHandDate, newValue: Date(), dateKeyPath: \.firstWinningHandDate,forceUpdate: true)
  }
  
  private func evaluateHand() -> HandRank {
    HandRank.evaluate(cards: currentHand)
  }
  
  private func updatePlayerData<T: Comparable>(
    currentValue: inout T?,
    newValue: T,
    dateKeyPath: WritableKeyPath<PlayerData, Date?>,
    forceUpdate: Bool = false
  ) {
    if let current = currentValue, current >= newValue, !forceUpdate {
      return
    }
    currentValue = newValue
    currentPlayerData[keyPath: dateKeyPath] = Date()
  }
  
  @discardableResult
  func exchangeCards(indices: [Int]) -> [Card] {
    guard videoPokerStateManager.currentState == .initialHand else { return currentHand }

    indices.forEach { index in
      if let newCard = deck.dealCard() {
        currentHand[index] = newCard
      }
    }
    
    return currentHand
  }
  
  func pay() {
    guard let bet = currentPlayerData.currentBet, bet > 0 else { return }

    if currentPlayerData.totalPoints >= bet {
      currentPlayerData.totalPoints -= bet
    }
    
    resetForNewRound()
  }
  
  func evaluateAndStoreHand() {
    let handRank = evaluateHand()
    winnings = handRank.winnings * (currentPlayerData.currentBet ?? 0)
    currentPlayerData.totalPoints += winnings
    checkAndUpdateBestHandIfNeeded(with: handRank)
    checkAndUpdateBiggestWin()
    checkAndUpdateFirstWinningHandDateIfNeeded()
    currentPlayerData.totalHandsPlayed += 1

    if handRank != .none {
      currentPlayerData.winningHands += 1
    }
    
    videoPokerStateManager.transition(to: .finalHand, with: currentPlayerData.currentBet)
  }
  
  func resetForNewRound() {
    videoPokerStateManager.transition(to: .initialHand, with: currentPlayerData.currentBet)
    winnings = 0
    deck.reset()
    currentHand = deck.drawCards(5)
  }
  
  func getHandName() -> String {
    evaluateHand().name
  }
}
