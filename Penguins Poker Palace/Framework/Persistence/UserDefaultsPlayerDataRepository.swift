//
//  UserDefaultsPlayerDataRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//

import Foundation


final class UserDefaultsPlayerDataRepository: PlayerDataRepository {
  private let bestHandKey = "bestHand"
  private let bestHandDateKey = "bestHandDate"
  private let currentBetKey = "currentBet"
  private let expertModeKey = "expertMode"
  private let firstWinningHandDateKey = "firstWinningHandDate"
  private let languageKey = "preferredLanguage"
  private let lateralityKey = "laterality"
  private let successfulBetsKey = "successfulBets"
  private let totalBetsKey = "totalBets"
  private let totalHandsPlayedKey = "totalHandsPlayed"
  private let totalPointsKey = "totalPoints"
  private let winningHandsKey = "winningHands"
  
  func savePlayerData(_ playerData: PlayerData) {
    let defaults = UserDefaults.standard
    defaults.set(playerData.bestHand?.rawValue, forKey: bestHandKey)
    defaults.set(playerData.bestHandDate?.timeIntervalSince1970, forKey: bestHandDateKey)
    defaults.set(playerData.currentBet, forKey: currentBetKey)
    defaults.set(playerData.expertMode, forKey: expertModeKey)

    if let firstWinningHandDate = playerData.firstWinningHandDate {
      defaults.set(firstWinningHandDate.timeIntervalSince1970, forKey: firstWinningHandDateKey)
    }

    defaults.set(playerData.language, forKey: languageKey)
    defaults.set(playerData.laterality?.rawValue, forKey: lateralityKey)
    defaults.set(playerData.successfulBets, forKey: successfulBetsKey)
    defaults.set(playerData.totalBets, forKey: totalBetsKey)
    defaults.set(playerData.totalHandsPlayed, forKey: totalHandsPlayedKey)
    defaults.set(playerData.totalPoints, forKey: totalPointsKey)
    defaults.set(playerData.winningHands, forKey: winningHandsKey)
  }
  
  func loadPlayerData() -> PlayerData? {
    let defaults = UserDefaults.standard
    
    guard
      let bestHandRaw = defaults.value(forKey: bestHandKey) as? Int,
      let bestHand = HandRank(rawValue: bestHandRaw),
      let bestHandDate = defaults.value(forKey: bestHandDateKey) as? TimeInterval,
      let language = defaults.string(forKey: languageKey),
      let lateralityRaw = defaults.string(forKey: lateralityKey),
      let laterality = Laterality(rawValue: lateralityRaw)
    else {
      return nil
    }
    
    let bestHandDateValue = Date(timeIntervalSince1970: bestHandDate)
    let currentBet = defaults.integer(forKey: currentBetKey)
    let expertMode = defaults.bool(forKey: expertModeKey)
    let firstWinningHandDate = defaults.value(forKey: firstWinningHandDateKey) as? TimeInterval
    let firstWinningHandDateValue = firstWinningHandDate != nil ? Date(timeIntervalSince1970: firstWinningHandDate!) : nil
    let successfulBets = defaults.integer(forKey: successfulBetsKey)
    let totalBets = defaults.integer(forKey: totalBetsKey)
    let totalHandsPlayed = defaults.integer(forKey: totalHandsPlayedKey)
    let totalPoints = defaults.integer(forKey: totalPointsKey)
    let winningHands = defaults.integer(forKey: winningHandsKey)
    
    return PlayerData(
      bestHand: bestHand,
      bestHandDate: bestHandDateValue,
      currentBet: currentBet,
      expertMode: expertMode,
      firstWinningHandDate: firstWinningHandDateValue,
      language: language,
      laterality: laterality,
      successfulBets: successfulBets,
      totalBets: totalBets,
      totalHandsPlayed: totalHandsPlayed,
      totalPoints: totalPoints,
      winningHands: winningHands
    )
  }
}
