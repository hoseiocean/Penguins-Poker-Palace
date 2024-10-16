//
//  PlayerData.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//

import Foundation


struct PlayerData {
  var bestHand: HandRank?
  var bestHandDate: Date?
  var biggestWin: Int?
  var biggestWinDate: Date?
  var currentBet: Int?
  var expertMode: Bool?
  var firstWinningHandDate: Date?
  var language: String?
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
    bestHand: HandRank?,
    bestHandDate: Date?,
    biggestWin: Int?,
    biggestWinDate: Date?,
    currentBet: Int?,
    expertMode: Bool?,
    firstWinningHandDate: Date?,
    language: String?,
    laterality: Laterality?,
    successfulBets: Int = 0,
    totalBets: Int = 0,
    totalHandsPlayed: Int = 0,
    totalPoints: Int = 0,
    winningHands: Int = 0
  ) {
    self.bestHand = bestHand
    self.bestHandDate = bestHandDate
    self.biggestWin = biggestWin
    self.biggestWinDate = biggestWinDate
    self.currentBet = currentBet
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
}
