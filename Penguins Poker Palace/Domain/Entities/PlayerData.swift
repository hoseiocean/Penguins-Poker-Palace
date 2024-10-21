//
//  PlayerData.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//

import Foundation


struct PlayerData {
  var bestCardRank: Rank?
  var bestHandRank: HandRank?
  var bestHandDate: Date?
  var biggestWin: Int?
  var biggestWinDate: Date?
  var currentBet: Int?
  var dailyWinningHistory: Set<Date>
  var expertMode: Bool?
  var firstWinningHandDate: Date?
  var language: String?
  var lastGiftDate: Date?
  var laterality: Laterality?
  var successfulBets: Int
  var totalBets: Int
  var totalHandsPlayed: Int
  var totalPoints: Int
  var winningHands: Int
  
  var ratioOfSuccessHandsAtPoker: Double {
    guard totalHandsPlayed > 0 else { return 0 }
    return Double(winningHands) / Double(totalHandsPlayed)
  }
  
  var ratioOfSuccessTriesAtBet: Double {
    guard totalBets > 0 else { return 0 }
    return Double(successfulBets) / Double(totalBets)
  }

  init(
    bestCardRank: Rank? = nil,
    bestHandRank: HandRank? = nil,
    bestHandDate: Date? = nil,
    biggestWin: Int? = nil,
    biggestWinDate: Date? = nil,
    currentBet: Int? = nil,
    dailyWinningHistory: Set<Date> = [],
    expertMode: Bool? = nil,
    firstWinningHandDate: Date? = nil,
    language: String? = nil,
    laterality: Laterality? = nil,
    successfulBets: Int = 0,
    totalBets: Int = 0,
    totalHandsPlayed: Int = 0,
    totalPoints: Int = 0,
    winningHands: Int = 0
  ) {
    self.bestCardRank = bestCardRank
    self.bestHandRank = bestHandRank
    self.bestHandDate = bestHandDate
    self.biggestWin = biggestWin
    self.biggestWinDate = biggestWinDate
    self.currentBet = currentBet
    self.dailyWinningHistory = dailyWinningHistory
    self.expertMode = expertMode
    self.firstWinningHandDate = firstWinningHandDate
    self.language = language
    self.laterality = laterality
    self.successfulBets = successfulBets
    self.totalBets = totalBets
    self.totalHandsPlayed = totalHandsPlayed
    self.totalPoints = totalPoints
    self.winningHands = winningHands
  }
  
  func giftIsAvailableForDate(_ date: Date) -> Bool {
    guard let lastGiftDate, Calendar.current.isDate(lastGiftDate, inSameDayAs: date) else { return true }
    return false
  }
  
  func hasWinningHandsForLastSevenDaysBeforeDate(_ date: Date) -> Bool {
    let calendar = Calendar.current
    
    for daysAgo in 1 ... 7 {
      guard let dayToCheck = calendar.date(byAdding: .day, value: -daysAgo, to: date) else {
        return false
      }
      
      if !dailyWinningHistory.contains(where: { calendar.isDate($0, inSameDayAs: dayToCheck) }) {
        return false
      }
    }
    
    return true
  }
  
  mutating func updateWinningHistory(for date: Date) {
    dailyWinningHistory.insert(date)
  }
}
