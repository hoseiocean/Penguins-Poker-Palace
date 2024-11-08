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
    lastGiftDate: Date? = nil,
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
    self.lastGiftDate = lastGiftDate
    self.laterality = laterality
    self.successfulBets = successfulBets
    self.totalBets = totalBets
    self.totalHandsPlayed = totalHandsPlayed
    self.totalPoints = totalPoints
    self.winningHands = winningHands

    checkAndAwardDailyPoints()
  }
  
  var isGiftAvailableForToday: Bool {
    if let lastGiftDate, Calendar.current.isDate(lastGiftDate, inSameDayAs: Date()) {
      print("Gift not available today, last gift date: \(lastGiftDate), current date: \(Date())")
      return false
    } else {
      print("Gift available today, last gift date: \(String(describing: lastGiftDate)), current date: \(Date())")
      return true
    }
  }
  
  var hasWinningHandsForLastSevenDays: Bool {
    let calendar = Calendar.current
    
    for daysAgo in 1 ... 7 {
      guard let dayToCheck = calendar.date(byAdding: .day, value: -daysAgo, to: Date()) else {
        print("Missing day dayAgo: \(daysAgo)")
        return false
      }
      print("OK for day: \(dayToCheck)")
      if !dailyWinningHistory.contains(where: { calendar.isDate($0, inSameDayAs: dayToCheck) }) {
        return false
      }
    }
    
    return true
  }
  
  @discardableResult
  private mutating func checkAndAwardDailyPoints() -> Int {
    guard
      isGiftAvailableForToday,
      hasWinningHandsForLastSevenDays
    else {
      return .zero
    }
    
    let pointsGiftRange = 1 ... 10
    let pointsGift = Int.random(in: pointsGiftRange)
    
    lastGiftDate = Date()
    totalPoints += pointsGift
    
    return pointsGift
  }
  
  func hasWinningHand(on date: Date) -> Bool {
    dailyWinningHistory.contains { storedDate in
      Calendar.current.isDate(storedDate, inSameDayAs: date)
    }
  }
  
  mutating func updateWinningHistory(for date: Date) {
    dailyWinningHistory.insert(date)
  }
}
