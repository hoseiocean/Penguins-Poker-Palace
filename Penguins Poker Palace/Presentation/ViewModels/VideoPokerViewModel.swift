//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


final class VideoPokerViewModel: ObservableObject {
  
  private let videoPoker: VideoPoker
  private let repository: PlayerDataRepository
  private let videoPokerStateManager: VideoPokerStateManager

  @Published var betInput: String = ""
  @Published var currentBet: Int? = nil
  @Published var currentHand: [Card] = []
  @Published var expertMode: Bool
  @Published var handName: String = ""
  @Published var laterality: Laterality
  @Published var showPlayerInfo: Bool = false
  
  var bestCardRank: String {
    guard let bestCardRank = videoPoker.currentPlayerData.bestCardRank else { return "Unknown" }
    return bestCardRank.name
  }
  
  var bestHandRank: String {
    guard let bestHandRank = videoPoker.currentPlayerData.bestHandRank else { return "Unknown" }
    return bestHandRank.name
  }
  
  var bestHandDate: Date? {
    videoPoker.currentPlayerData.bestHandDate
  }
  
  var biggestWin: String {
    guard let biggestWin = videoPoker.currentPlayerData.biggestWin else { return "Unknown" }
    return String(biggestWin)
  }
  
  var biggestWinDate: Date? {
    videoPoker.currentPlayerData.biggestWinDate
  }
  
  var currentBetString: String {
    guard let currentBet = videoPoker.currentPlayerData.currentBet else { return "Unknown" }
    return String(currentBet)
  }
  
  var firstWinningHandDate: Date? {
    videoPoker.currentPlayerData.firstWinningHandDate
  }
  
  var language: String {
    videoPoker.currentPlayerData.language ?? String()
  }
  
  var pokerLevel: PokerLevel {
    PlayerLevelDetermination.determinePlayerLevel(playerData: videoPoker.currentPlayerData)
  }
  
  var successfulBets: Int {
    videoPoker.currentPlayerData.successfulBets
  }
  
  var totalBets: Int {
    videoPoker.currentPlayerData.totalBets
  }
  
  var totalHandsPlayed: Int {
    videoPoker.currentPlayerData.totalHandsPlayed
  }
  
  var totalPoints: Int {
    videoPoker.currentPlayerData.totalPoints
  }
  
  var winningHands: Int {
    videoPoker.currentPlayerData.winningHands
  }
  
  var winnings: Int {
    videoPoker.winnings
  }
  
  var handState: HandState {
    videoPokerStateManager.currentState
  }
  
  init(videoPoker: VideoPoker, repository: PlayerDataRepository, videoPokerStateManager: VideoPokerStateManager) {
    self.videoPoker = videoPoker
    self.repository = repository
    self.videoPokerStateManager = videoPokerStateManager
    expertMode = videoPoker.currentPlayerData.expertMode ?? false
    laterality = videoPoker.currentPlayerData.laterality ?? .right
    loadGameState()
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    videoPoker.exchangeCards(indices: indices)
    videoPoker.evaluateAndStoreHand()
    updateState()
    saveGameState()
  }
  
  func loadGameState() {
    guard let loadedPlayerData = repository.loadPlayerData() else { return }
    videoPoker.currentPlayerData = loadedPlayerData
  }

  func saveGameState() {
    repository.savePlayerData(videoPoker.currentPlayerData)
  }

  func setBet(_ bet: String) {
    guard let betValue = Int(bet) else { return }

    currentBet = min(max(betValue, 1), videoPoker.currentPlayerData.totalPoints)
    videoPoker.currentPlayerData.currentBet = currentBet
    betInput = ""
    videoPokerStateManager.currentState = .finalHand
    saveGameState()
  }
  
  func startNewRound() {
    guard videoPokerStateManager.currentState != .initializing else { return }
    videoPoker.pay()
    updateState()
    saveGameState()
  }
  
  private func updateState() {
    currentHand = videoPoker.currentHand
    handName = videoPoker.getHandName()
    switch videoPokerStateManager.currentState {
    case .initialHand:
        videoPokerStateManager.transition(to: .finalHand, with: videoPoker.currentPlayerData.currentBet)
    case .finalHand:
        videoPokerStateManager.transition(to: .initialHand, with: videoPoker.currentPlayerData.currentBet)
    default:
        return
    }
  }
}

extension VideoPokerViewModel {
  
  private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .short
    return formatter
  }
  
  func formatDate(_ date: Date?) -> String {
    guard let date = date else { return "Unknown" }
    return dateFormatter.string(from: date).localizedCapitalized
  }
}
