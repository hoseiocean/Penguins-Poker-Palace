//
//  InMemoryGameRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class InMemoryGameRepository: GameRepository {
  private var savedGame: VideoPokerGame?
  
  func loadGameState() -> VideoPokerGame? {
    savedGame
  }

  func saveGameState(_ game: VideoPokerGame) {
    savedGame = game
  }
}
