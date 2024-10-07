//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


class VideoPokerViewModel: ObservableObject {
  @Published var currentHand: [Card] = []
  
  private let game: VideoPokerGame
  private let repository: GameRepository

  init(game: VideoPokerGame, repository: GameRepository) {
    self.game = game
    self.repository = repository
    loadGameState()
  }
  
  func dealHand() {
    currentHand = game.dealHand()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    currentHand = game.exchangeCards(indices: indices)
  }
  
  func loadGameState() {
    if let loadedGame = repository.loadGameState() {
      currentHand = loadedGame.currentHand
    } else {
      dealHand()
    }
  }
  
  func resetGame() {
    game.resetGame()
    currentHand = game.currentHand
  }
}
