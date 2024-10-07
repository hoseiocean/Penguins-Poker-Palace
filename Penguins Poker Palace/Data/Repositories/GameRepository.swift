//
//  GameRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


protocol GameRepository {
  func loadGameState() -> VideoPokerGame?
  func saveGameState(_ game: VideoPokerGame)
}
