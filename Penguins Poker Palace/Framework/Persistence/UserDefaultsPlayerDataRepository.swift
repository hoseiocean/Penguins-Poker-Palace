//
//  UserDefaultsPlayerDataRepository.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//

import Foundation


final class UserDefaultsPlayerDataRepository: PlayerDataRepository {
  private let bestCardRankKey = "bestCardRank"
  private let bestHandRankKey = "bestHandRank"
  private let bestHandDateKey = "bestHandDate"
  private let biggestWinKey = "biggestWin"
  private let biggestWinDateKey = "biggestWinDate"
  private let currentBetKey = "currentBet"
  private let dailyWinningHistoryKey = "dailyWinningHistory"
  private let expertModeKey = "expertMode"
  private let firstWinningHandDateKey = "firstWinningHandDate"
  private let hasPlayedBeforeKey = "hasPlayedBefore"
  private let languageKey = "preferredLanguage"
  private let lastGiftDateKey = "lastGiftDate"
  private let lateralityKey = "laterality"
  private let successfulBetsKey = "successfulBets"
  private let totalBetsKey = "totalBets"
  private let totalHandsPlayedKey = "totalHandsPlayed"
  private let totalPointsKey = "totalPoints"
  private let winningHandsKey = "winningHands"
  
  private var cachedPlayerData: PlayerData?
  
  
  func loadPlayerData() -> PlayerData {
    if let cached = cachedPlayerData {
      return cached
    }
    
    let defaults = UserDefaults.standard
    
    if !defaults.bool(forKey: hasPlayedBeforeKey) {
      let newPlayerData = PlayerData(totalPoints: 100)
      savePlayerData(newPlayerData)
      defaults.set(true, forKey: hasPlayedBeforeKey)
      cachedPlayerData = newPlayerData
      return newPlayerData
    }
    
    let bestCardRank: Rank?
    if let bestCardRaw = defaults.value(forKey: bestCardRankKey) as? Int {
      bestCardRank = Rank(rawValue: bestCardRaw)
    } else {
      bestCardRank = nil
    }
    
    let bestHandRank: HandRank?
    if let bestHandRaw = defaults.value(forKey: bestHandRankKey) as? Int {
      bestHandRank = HandRank(rawValue: bestHandRaw)
    } else {
      bestHandRank = nil
    }
    
    let bestHandDateValue: Date?
    if let bestHandDate = defaults.value(forKey: bestHandDateKey) as? TimeInterval {
      bestHandDateValue = Date(timeIntervalSince1970: bestHandDate)
    } else {
      bestHandDateValue = nil
    }
    
    let biggestWin = defaults.value(forKey: biggestWinKey) as? Int
    
    let biggestWinDateValue: Date?
    if let biggestWinDate = defaults.value(forKey: biggestWinDateKey) as? TimeInterval {
      biggestWinDateValue = Date(timeIntervalSince1970: biggestWinDate)
    } else {
      biggestWinDateValue = nil
    }
    
    let currentBet = defaults.integer(forKey: currentBetKey)
    
    let winningHistoryTimestamps = defaults.array(forKey: dailyWinningHistoryKey) as? [TimeInterval] ?? []
    let dailyWinningHistory: Set<Date> = Set(winningHistoryTimestamps.map { Date(timeIntervalSince1970: $0) })
    
    let expertMode = defaults.bool(forKey: expertModeKey)
    let firstWinningHandDate = defaults.value(forKey: firstWinningHandDateKey) as? TimeInterval
    let firstWinningHandDateValue = firstWinningHandDate != nil ? Date(timeIntervalSince1970: firstWinningHandDate!) : nil
    
    let lastGiftDate = defaults.value(forKey: lastGiftDateKey) as? TimeInterval
    let lastGiftDateValue = lastGiftDate != nil ? Date(timeIntervalSince1970: lastGiftDate!) : nil
    
    let language = defaults.string(forKey: languageKey)
    let lateralityRaw = defaults.string(forKey: lateralityKey) ?? Laterality.right.rawValue
    let laterality = Laterality(rawValue: lateralityRaw)
    
    let successfulBets = defaults.integer(forKey: successfulBetsKey)
    let totalBets = defaults.integer(forKey: totalBetsKey)
    let totalHandsPlayed = defaults.integer(forKey: totalHandsPlayedKey)
    let totalPoints = defaults.integer(forKey: totalPointsKey)
    let winningHands = defaults.integer(forKey: winningHandsKey)
    
    let playerData = PlayerData(
      bestCardRank: bestCardRank,
      bestHandRank: bestHandRank,
      bestHandDate: bestHandDateValue,
      biggestWin: biggestWin,
      biggestWinDate: biggestWinDateValue,
      currentBet: currentBet,
      dailyWinningHistory: dailyWinningHistory,
      expertMode: expertMode,
      firstWinningHandDate: firstWinningHandDateValue,
      language: language,
      lastGiftDate: lastGiftDateValue,
      laterality: laterality,
      successfulBets: successfulBets,
      totalBets: totalBets,
      totalHandsPlayed: totalHandsPlayed,
      totalPoints: totalPoints,
      winningHands: winningHands
    )

    cachedPlayerData = playerData
    return playerData
  }
  
  func savePlayerData(_ playerData: PlayerData) {
    let defaults = UserDefaults.standard
    defaults.set(playerData.bestCardRank?.rawValue, forKey: bestCardRankKey)
    defaults.set(playerData.bestHandRank?.rawValue, forKey: bestHandRankKey)
    defaults.set(playerData.bestHandDate?.timeIntervalSince1970, forKey: bestHandDateKey)
    defaults.set(playerData.biggestWin, forKey: biggestWinKey)
    defaults.set(playerData.biggestWinDate?.timeIntervalSince1970, forKey: biggestWinDateKey)
    defaults.set(playerData.currentBet, forKey: currentBetKey)
    
    let winningHistoryTimestamps = playerData.dailyWinningHistory.map { $0.timeIntervalSince1970 }
    defaults.set(winningHistoryTimestamps, forKey: dailyWinningHistoryKey)
    
    defaults.set(playerData.expertMode, forKey: expertModeKey)
    
    if let firstWinningHandDate = playerData.firstWinningHandDate {
      defaults.set(firstWinningHandDate.timeIntervalSince1970, forKey: firstWinningHandDateKey)
    }
    
    defaults.set(playerData.language, forKey: languageKey)
    
    if let lastGiftDate = playerData.lastGiftDate {
      defaults.set(lastGiftDate.timeIntervalSince1970, forKey: lastGiftDateKey)
    }
    
    defaults.set(playerData.laterality?.rawValue, forKey: lateralityKey)
    defaults.set(playerData.successfulBets, forKey: successfulBetsKey)
    defaults.set(playerData.totalBets, forKey: totalBetsKey)
    defaults.set(playerData.totalHandsPlayed, forKey: totalHandsPlayedKey)
    defaults.set(playerData.totalPoints, forKey: totalPointsKey)
    defaults.set(playerData.winningHands, forKey: winningHandsKey)
    
    cachedPlayerData = playerData
  }
}
