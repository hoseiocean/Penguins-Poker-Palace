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
  
  private let game: VideoPokerGame
  private let repository: GameRepository
  
  init(game: VideoPokerGame, repository: GameRepository) {
    self.game = game
    self.repository = repository
    loadGameState()
  }
  
  func dealHand() {
    currentHand = game.dealHand()
    handName = game.getHandName()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    currentHand = game.exchangeCards(indices: indices)
    handName = game.getHandName()
    saveGameState()
  }
  
  func loadGameState() {
    if let loadedGame = repository.loadGameState() {
      currentHand = loadedGame.currentHand
      handName = game.getHandName()
    } else {
      dealHand()
    }
  }
  
  func resetGame() {
    game.resetGame()
    currentHand = game.currentHand
    handName = game.getHandName()
    saveGameState()
  }

  func saveGameState() {
    repository.saveGameState(game)
  }
}
