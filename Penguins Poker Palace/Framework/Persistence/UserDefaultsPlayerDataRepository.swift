//
//  UserDefaultsPlayerDataRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//

import Foundation


final class UserDefaultsPlayerDataRepository: PlayerDataRepository {
  private let beginnerModeKey = "beginnerMode"
  private let bestHandKey = "bestHand"
  private let bestHandDateKey = "bestHandDate"
  private let currentBetKey = "currentBet"
  private let firstWinningHandDateKey = "firstWinningHandDate"
  private let handPreferenceKey = "handPreference"
  private let pokerLevelKey = "pokerLevel"
  private let preferredLanguageKey = "preferredLanguage"
  private let successfulBetsKey = "successfulBets"
  private let totalBetsKey = "totalBets"
  private let totalHandsPlayedKey = "totalHandsPlayed"
  private let totalPointsKey = "totalPoints"
  private let winningHandsKey = "winningHands"
  
  func savePlayerData(_ playerData: PlayerData) {
    let defaults = UserDefaults.standard
    defaults.set(playerData.beginnerMode, forKey: beginnerModeKey)
    defaults.set(playerData.bestHand?.rawValue, forKey: bestHandKey)
    defaults.set(playerData.bestHandDate?.timeIntervalSince1970, forKey: bestHandDateKey)
    defaults.set(playerData.currentBet, forKey: currentBetKey)

    if let firstWinningHandDate = playerData.firstWinningHandDate {
      defaults.set(firstWinningHandDate.timeIntervalSince1970, forKey: firstWinningHandDateKey)
    }

    defaults.set(playerData.handPreference?.rawValue, forKey: handPreferenceKey)
    defaults.set(playerData.totalPoints, forKey: totalPointsKey)
    defaults.set(playerData.pokerLevel?.rawValue, forKey: pokerLevelKey)
    defaults.set(playerData.preferredLanguage, forKey: preferredLanguageKey)
    defaults.set(playerData.successfulBets, forKey: successfulBetsKey)
    defaults.set(playerData.totalBets, forKey: totalBetsKey)
    defaults.set(playerData.totalHandsPlayed, forKey: totalHandsPlayedKey)
    defaults.set(playerData.winningHands, forKey: winningHandsKey)
  }
  
  func loadPlayerData() -> PlayerData? {
    let defaults = UserDefaults.standard
    
    guard
      let bestHandRaw = defaults.value(forKey: bestHandKey) as? Int,
      let bestHand = HandRank(rawValue: bestHandRaw),
      let bestHandDate = defaults.value(forKey: bestHandDateKey) as? TimeInterval,
      let handPreferenceRaw = defaults.string(forKey: handPreferenceKey),
      let handPreference = HandPreference(rawValue: handPreferenceRaw),
      let pokerLevelRaw = defaults.string(forKey: pokerLevelKey),
      let pokerLevel = PokerLevel(rawValue: pokerLevelRaw),
      let preferredLanguage = defaults.string(forKey: preferredLanguageKey)
    else {
      return nil
    }
    
    let beginnerMode = defaults.bool(forKey: beginnerModeKey)
    let bestHandDateValue = Date(timeIntervalSince1970: bestHandDate)
    let currentBet = defaults.integer(forKey: currentBetKey)
    let firstWinningHandDate = defaults.value(forKey: firstWinningHandDateKey) as? TimeInterval
    let firstWinningHandDateValue = firstWinningHandDate != nil ? Date(timeIntervalSince1970: firstWinningHandDate!) : nil
    let successfulBets = defaults.integer(forKey: successfulBetsKey)
    let totalBets = defaults.integer(forKey: totalBetsKey)
    let totalHandsPlayed = defaults.integer(forKey: totalHandsPlayedKey)
    let totalPoints = defaults.integer(forKey: totalPointsKey)
    let winningHands = defaults.integer(forKey: winningHandsKey)
    
    return PlayerData(
      beginnerMode: beginnerMode,
      bestHand: bestHand,
      bestHandDate: bestHandDateValue,
      currentBet: currentBet,
      firstWinningHandDate: firstWinningHandDateValue,
      handPreference: handPreference,
      pokerLevel: pokerLevel,
      preferredLanguage: preferredLanguage,
      successfulBets: successfulBets,
      totalBets: totalBets,
      totalHandsPlayed: totalHandsPlayed,
      totalPoints: totalPoints,
      winningHands: winningHands
    )
  }
}
