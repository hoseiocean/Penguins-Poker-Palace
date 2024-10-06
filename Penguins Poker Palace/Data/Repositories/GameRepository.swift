//
//  GameRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


protocol GameRepository {
  func saveGameState(_ game: VideoPokerGame)
  func loadGameState() -> VideoPokerGame?
}
