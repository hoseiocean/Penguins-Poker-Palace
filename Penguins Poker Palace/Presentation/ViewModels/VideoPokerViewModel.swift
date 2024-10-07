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
  @Published var handState: HandState = .initialHand
  @Published var totalPoints: Int = 100
  @Published var currentBet: Int = 1
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
    currentBet = min(max(currentBet, 1), totalPoints)
  }
  
  // Gestion de la mise
  func setBet(_ bet: Int) {
    if totalPoints > 0 {
      currentBet = min(max(bet, 1), totalPoints)
    } else {
      currentBet = 0
    }
    updateState()
  }
  
  func startNewRound() {
    guard handState == .finalHand || handState == .initialHand else { return }
    
    if totalPoints >= currentBet {
      totalPoints -= currentBet
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
    let handRank = game.evaluateHand()
    winnings = handRank.winnings * currentBet
    totalPoints += winnings
    updateState()
  }
  
  func loadGameState() {
    updateState()
  }
  
  func saveGameState() {
  }
}
