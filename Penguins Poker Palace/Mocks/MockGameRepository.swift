//
//  MockGameRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class MockGameRepository: GameRepository {
  func saveGameState(_ game: VideoPokerGame) {
  }
  
  func loadGameState() -> VideoPokerGame? {
    nil
  }
}
