//
//  PlayerDataRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//


protocol PlayerDataRepository {
  func loadPlayerData() -> PlayerData
  func savePlayerData(_ playerData: PlayerData)
}
