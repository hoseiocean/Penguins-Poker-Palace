//
//  MockGameRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class MockPlayerDataRepository: PlayerDataRepository {
  func savePlayerData(_ playerData: PlayerData) {
  }
  
  func loadPlayerData() -> PlayerData {
    PlayerData()
  }
}
