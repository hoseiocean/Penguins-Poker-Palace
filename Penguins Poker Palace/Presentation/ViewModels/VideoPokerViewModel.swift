//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


class VideoPokerViewModel: ObservableObject {
  @Published var hand: [Card] = []
  @Published var handRank: HandRank = .highCard
  
  private let game: VideoPokerGame
  private let repository: GameRepository
  
  init(game: VideoPokerGame, repository: GameRepository) {
    self.game = game
    self.repository = repository
  }
  
  func dealHand() {
    hand = game.dealHand()
    handRank = game.evaluateHand()
  }
  
  func saveGame() {
    repository.saveGameState(game)
  }
  
  func loadGame() {
    if let loadedGame = repository.loadGameState() {
      hand = loadedGame.currentHand
      handRank = loadedGame.evaluateHand()
    }
  }
}
