//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


final class VideoPokerViewModel: ObservableObject {
  
  private let game: VideoPokerGame
  private let repository: PlayerDataRepository

  @Published var betInput: String = ""
  @Published var currentBet: Int? = nil
  @Published var currentHand: [Card] = []
  @Published var expertMode: Bool
  @Published var handName: String = ""
  @Published var handState: HandState = .initializing
  @Published var laterality: Laterality
  @Published var showPlayerInfo: Bool = false
  @Published var winnings: Int = 0
  
  var bestHand: String {
    guard let bestHand = game.currentPlayerData.bestHand else { return "Unknown" }
    return bestHand.name
  }
  
  var bestHandDate: String {
    guard let date = game.currentPlayerData.bestHandDate else { return "Unknown" }
    return date.formatted()
  }
  
  var bestHandDateRaw: Date {
    game.currentPlayerData.bestHandDate ?? Date()
  }
  
  var currentBetString: String {
    guard let currentBet = game.currentPlayerData.currentBet else { return "Unknown" }
    return String(currentBet)
  }
  
  var firstWinningHandDate: String {
    guard let date = game.currentPlayerData.firstWinningHandDate else { return "Unknown" }
    return date.formatted()
  }
  
  var language: String {
    game.currentPlayerData.language ?? String()
  }
  
  var pokerLevel: PokerLevel {
    PlayerLevelDetermination.determinePlayerLevel(playerData: game.currentPlayerData)
  }
  
  var successfulBets: Int {
    game.currentPlayerData.successfulBets
  }
  
  var totalBets: Int {
    game.currentPlayerData.totalBets
  }
  
  var totalHandsPlayed: Int {
    game.currentPlayerData.totalHandsPlayed
  }
  
  var totalPoints: Int {
    game.currentPlayerData.totalPoints
  }
  
  var winningHands: Int {
    game.currentPlayerData.winningHands
  }
  
  init(game: VideoPokerGame, repository: PlayerDataRepository) {
    self.game = game
    self.repository = repository
    expertMode = game.currentPlayerData.expertMode ?? false
    laterality = game.currentPlayerData.laterality ?? .right

    loadGameState()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    game.exchangeCards(indices: indices)
    finalizeHand()
  }
  
  func loadGameState() {
    if let loadedPlayerData = repository.loadPlayerData() {
      game.currentPlayerData = loadedPlayerData
      handState = .finalHand
    } else {
      resetGame()
    }
  }

  func saveGameState() {
    repository.savePlayerData(game.currentPlayerData)
  }

  func setBet(_ bet: Int) {
    game.placeBet(bet)
    betInput = ""
    saveGameState()

    if handState == .initializing, game.currentPlayerData.currentBet != nil {
      handState = .initialHand
      startNewRound()
    }
  }
  
  func startNewRound() {
    guard handState != .initializing else { return }
    
    game.startNewRound()
    updateState()
    saveGameState()
  }
  
  private func finalizeHand() {
    let handRank = game.finalizeHand()
    winnings = handRank.winnings * (game.currentPlayerData.currentBet ?? 0)
    updateState()
    saveGameState()
  }
  
  private func updateState() {
    currentHand = game.currentHand
    handName = game.getHandName()
    handState = game.handState
  }

  private func resetGame() {
    currentBet = nil
    handState = .initializing
  }
}

extension VideoPokerViewModel {
  
  private var longDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    return formatter
  }

  var formattedBestHandDate: String {
    guard let date = game.currentPlayerData.bestHandDate else { return "Unknown" }
    return longDateFormatter.string(from: date)
  }
}
