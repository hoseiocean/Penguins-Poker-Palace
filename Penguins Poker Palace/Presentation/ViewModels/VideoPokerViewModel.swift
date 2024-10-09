//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


final class VideoPokerViewModel: ObservableObject {
  @Published var betInput: String = ""
  @Published var currentBet: Int? = nil
  @Published var currentHand: [Card] = []
  @Published var handName: String = ""
  @Published var handState: HandState = .initializing
  @Published var totalPoints: Int = 100
  @Published var winnings: Int = 0
  
  private let game: VideoPokerGame
  private let repository: PlayerDataRepository
  
  init(game: VideoPokerGame, repository: PlayerDataRepository) {
    self.game = game
    self.repository = repository
    loadGameState()
  }
  
  private func updateState() {
    currentHand = game.currentHand
    handName = game.getHandName()
    handState = game.handState
    totalPoints = game.currentPlayerData.totalPoints
  }
  
  func finalizeHand() {
    let handRank = game.finalizeHand()
    winnings = handRank.winnings * (currentBet ?? 0)
    updateState()
    saveGameState()
  }
  
  func setBet(_ bet: Int) {
    if totalPoints > 0 {
      currentBet = min(max(bet, 1), totalPoints)
    } else {
      currentBet = 0
    }
    
    game.currentPlayerData.currentBet = currentBet
    saveGameState()

    betInput = ""
    
    if handState == .initializing, currentBet != nil {
      handState = .initialHand
      startNewRound()
    }
  }
  
  func startNewRound() {
    guard handState != .initializing else { return }
    guard let bet = currentBet else { return }
    
    if totalPoints >= bet {
      totalPoints -= bet
      game.currentPlayerData.totalPoints = totalPoints
      game.currentPlayerData.currentBet = bet
    } else {
      totalPoints -= 0
      game.currentPlayerData.totalPoints = totalPoints
      game.currentPlayerData.currentBet = 0
    }
    
    game.resetForNewRound()
    winnings = 0
    updateState()
    saveGameState()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    game.exchangeCards(indices: indices)
    finalizeHand()
  }
  
  func saveGameState() {
    repository.savePlayerData(game.currentPlayerData)
  }
  
  func loadGameState() {
    if let loadedPlayerData = repository.loadPlayerData() {
      currentBet = loadedPlayerData.currentBet
      game.currentPlayerData = loadedPlayerData
      handState = .finalHand
      totalPoints = loadedPlayerData.totalPoints
    } else {
      currentBet = nil
      handState = .initializing
    }
  }
}
