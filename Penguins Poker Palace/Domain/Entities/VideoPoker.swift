//
//  VideoPoker.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


typealias HandEvaluation = (handRank: HandRank, cardRank: Rank)
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
    startNewSession()
  }
  
  @discardableResult
  private func checkAndAwardDailyPoints() -> Int {
    let today = Calendar.current.startOfDay(for: Date())
    
    guard
      currentPlayerData.giftIsAvailableForDate(today),
      currentPlayerData.hasWinningHandsForLastSevenDaysBeforeDate(today)
    else {
      return .zero
    }
    
    let giftRange = 1 ... 10
    let pointsGift = Int.random(in: giftRange)
    
    currentPlayerData.lastGiftDate = today
    currentPlayerData.totalPoints += pointsGift
    
    return pointsGift
  }

  private func checkAndUpdateBestHandIfNeeded(with evaluation: HandEvaluation) {
    if let bestHand = currentPlayerData.bestHandRank, let bestCard = currentPlayerData.bestCardRank {
      guard evaluation.handRank > bestHand, evaluation.cardRank > bestCard else { return }
    }
    currentPlayerData.bestCardRank = evaluation.cardRank
    currentPlayerData.bestHandRank = evaluation.handRank
    currentPlayerData.bestHandDate = Date()
  }
  
  private func checkAndUpdateBiggestWin() {
    let biggestWin = currentPlayerData.biggestWin ?? 0
    guard winnings > biggestWin else { return }
    currentPlayerData.biggestWin = winnings
    currentPlayerData.biggestWinDate = Date()
  }
  
  private func checkAndUpdateFirstWinningHandDateIfNeeded() {
    guard currentPlayerData.firstWinningHandDate == nil else { return }
    currentPlayerData.firstWinningHandDate = Date()
  }
  
  private func evaluateHand() -> HandEvaluation {
    HandRank.evaluate(cards: currentHand)
  }
  
  func getLongestWinningStreak() -> Int {
    let winningDays = currentPlayerData.dailyWinningHistory.sorted()
    
    var longestStreak = 0
    var currentStreak = 0
    var previousDay: Date?
    
    for day in winningDays {
      if let previous = previousDay, Calendar.current.isDate(day, equalTo: previous, toGranularity: .day) {
        continue
      } else if let previous = previousDay, let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: previous), Calendar.current.isDate(day, equalTo: nextDay, toGranularity: .day) {        // Si le jour actuel est consécutif au jour précédent
        currentStreak += 1
      } else {
        longestStreak = max(longestStreak, currentStreak)
        currentStreak = 1
      }
      previousDay = day
    }
    
    longestStreak = max(longestStreak, currentStreak)
    
    return longestStreak
  }

  func startNewSession() {
    checkAndAwardDailyPoints()
  }
  
  private func updateWinningHistoryIfNeeded() {
    let today = Calendar.current.startOfDay(for: Date())
    
    if currentPlayerData.dailyWinningHistory.contains(where: { Calendar.current.isDate($0, inSameDayAs: today) }) {
      return
    }

    currentPlayerData.dailyWinningHistory.insert(today)
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
    let evaluation = evaluateHand()
    winnings = evaluation.handRank.winnings * (currentPlayerData.currentBet ?? 0)
    currentPlayerData.totalPoints += winnings
    checkAndUpdateBestHandIfNeeded(with: evaluation)
    checkAndUpdateBiggestWin()
    checkAndUpdateFirstWinningHandDateIfNeeded()
    currentPlayerData.totalHandsPlayed += 1

    if evaluation.handRank != .none {
      currentPlayerData.winningHands += 1
      updateWinningHistoryIfNeeded()
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
    evaluateHand().handRank.name
  }
}
