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
  }
  
  func dealHand() {
    game.dealHand()
    updateState()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    game.exchangeCards(indices: indices)
    updateState()
    saveGameState()
  }
  
  func loadGameState() {
    if let loadedGame = repository.loadGameState() {
      currentHand = loadedGame.currentHand
      handName = game.getHandName()  // Ici on peut choisir de réévaluer
      handState = game.handState
    } else {
      resetGame()
      dealHand()
    }
  }
  
  func resetGame() {
    game.resetGame()
    updateState()
    saveGameState()
  }
  
  func saveGameState() {
    repository.saveGameState(game)
  }
}
