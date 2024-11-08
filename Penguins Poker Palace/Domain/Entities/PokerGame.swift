//
//  PokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


class PokerGame {
  private let deck: Deck
  
  private(set) var currentHand: [Card] = []
  private(set) var winnings: Int = 0
  
  init(deck: Deck) {
    self.deck = deck
  }
  
  private func evaluateHand() -> HandEvaluation? {
    HandRank.evaluate(cards: currentHand)
  }
  
  func evaluateAndStoreHand(playerData: inout PlayerData) {
    guard let evaluation = evaluateHand() else { return }
    
    winnings = evaluation.handRank.winnings * (playerData.currentBet ?? 0)
    playerData.totalPoints += winnings
    playerData.totalHandsPlayed += 1
    
    if evaluation.handRank != .none {
      playerData.winningHands += 1
      
      // Update best hand if needed
      if let bestHand = playerData.bestHandRank,
         let bestCard = playerData.bestCardRank {
        if evaluation.handRank > bestHand ||
            (evaluation.handRank == bestHand && evaluation.cardRank > bestCard) {
          updateBestHand(playerData: &playerData, evaluation: evaluation)
        }
      } else {
        updateBestHand(playerData: &playerData, evaluation: evaluation)
      }
      
      // Update biggest win if needed
      if let currentBiggestWin = playerData.biggestWin {
        if winnings > currentBiggestWin {
          updateBiggestWin(playerData: &playerData)
        }
      } else {
        updateBiggestWin(playerData: &playerData)
      }
      
      // Update first winning hand date if needed
      if playerData.firstWinningHandDate == nil {
        playerData.firstWinningHandDate = Date()
      }
      
      // Update daily winning history
      let today = Calendar.current.startOfDay(for: Date())
      if !playerData.dailyWinningHistory.contains(where: {
        Calendar.current.isDate($0, inSameDayAs: today)
      }) {
        playerData.dailyWinningHistory.insert(today)
      }
    }
  }
  
  private func updateBestHand(playerData: inout PlayerData, evaluation: HandEvaluation) {
    playerData.bestCardRank = evaluation.cardRank
    playerData.bestHandRank = evaluation.handRank
    playerData.bestHandDate = Date()
  }
  
  private func updateBiggestWin(playerData: inout PlayerData) {
    playerData.biggestWin = winnings
    playerData.biggestWinDate = Date()
  }
  
  @discardableResult
  func exchangeCards(indices: [Int]) -> [Card] {
    indices.forEach { index in
      if let newCard = deck.dealCard() {
        currentHand[index] = newCard
      }
    }
    return currentHand
  }
  
  func getHandName() -> String {
    evaluateHand()?.handRank.name ?? ""
  }
  
  func pay(playerData: inout PlayerData) {
    guard let bet = playerData.currentBet,
          bet > 0,
          playerData.totalPoints >= bet else {
      return
    }
    
    playerData.totalPoints -= bet
    resetForNewRound()
  }
  
  func resetForNewRound() {
    winnings = 0
    deck.reset()
    currentHand = deck.drawCards(5)
  }
}
