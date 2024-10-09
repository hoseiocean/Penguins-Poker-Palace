//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


final class VideoPokerViewModel: ObservableObject {
  @Published var currentHand: [Card] = []
  @Published var handName: String = ""
  @Published var handState: HandState = .initializing
  @Published var totalPoints: Int = 100
  @Published var currentBet: Int? = nil
  @Published var winnings: Int = 0
  
  private let game: VideoPokerGame
  private let repository: GameRepository
  
  init(game: VideoPokerGame, repository: GameRepository) {
    self.game = game
    self.repository = repository
    loadGameState()
  }
  
  private func updateState() {
    currentHand = game.currentHand
    handName = game.getHandName()
    handState = game.handState
    totalPoints = max(0, totalPoints)
    if let bet = currentBet {
      currentBet = min(max(bet, 1), totalPoints)
    }
  }
  
  func setBet(_ bet: Int) {
    if totalPoints > 0 {
      currentBet = min(max(bet, 1), totalPoints)
    } else {
      currentBet = 0
    }
    
    if handState == .initializing {
      handState = .initialHand
      startNewRound()
    }
  }
  
  func startNewRound() {
    guard let bet = currentBet, bet > 0 else { return }
    
    if totalPoints >= bet {
      totalPoints -= bet
    }
    
    game.resetForNewRound()
    winnings = 0
    updateState()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    game.exchangeCards(indices: indices)
    finalizeHand()
  }
  
  func finalizeHand() {
    guard let currentBet else { return }
    let handRank = game.evaluateHand()
    winnings = handRank.winnings * currentBet
    totalPoints += winnings
    updateState()
  }
  
  func loadGameState() {
    if let savedGame = repository.loadGameState() {
//      totalPoints = savedGame.totalPoints
//      currentBet = savedGame.currentBet
      updateState()
    } else {
      currentBet = nil
    }
    handState = .initializing
  }
  
  func saveGameState() {
  }
}
