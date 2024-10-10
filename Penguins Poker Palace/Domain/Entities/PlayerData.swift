//
//  PlayerData.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//

import Foundation


struct PlayerData {
  var beginnerMode: Bool?
  var bestHand: HandRank?
  var bestHandDate: Date?
  var currentBet: Int?
  var firstWinningHandDate: Date?
  var laterality: Laterality?
  var pokerLevel: PokerLevel?
  var preferredLanguage: String?
  var successfulBets: Int
  var totalBets: Int
  var totalHandsPlayed: Int
  var totalPoints: Int
  var winningHands: Int
  
  init(
    beginnerMode: Bool,
    bestHand: HandRank,
    bestHandDate: Date,
    currentBet: Int?,
    firstWinningHandDate: Date?,
    laterality: Laterality,
    pokerLevel: PokerLevel,
    preferredLanguage: String,
    successfulBets: Int = 0,
    totalBets: Int = 0,
    totalHandsPlayed: Int = 0,
    totalPoints: Int,
    winningHands: Int = 0
  ) {
    self.beginnerMode = beginnerMode
    self.bestHand = bestHand
    self.bestHandDate = bestHandDate
    self.currentBet = currentBet
    self.firstWinningHandDate = firstWinningHandDate
    self.laterality = laterality
    self.pokerLevel = pokerLevel
    self.preferredLanguage = preferredLanguage
    self.successfulBets = successfulBets
    self.totalBets = totalBets
    self.totalHandsPlayed = totalHandsPlayed
    self.totalPoints = totalPoints
    self.winningHands = winningHands
  }
}

extension PlayerData {
  var ratioOfSuccessHandsAtPoker: Double {
    guard totalHandsPlayed > 0 else { return 0 }
    return Double(winningHands) / Double(totalHandsPlayed)
  }
  
  var ratioOfSuccessTriesAtBet: Double {
    guard totalBets > 0 else { return 0 }
    return Double(successfulBets) / Double(totalBets)
  }
}
