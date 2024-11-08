//
//  VideoPokerViewModel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import Foundation


final class VideoPokerViewModel: ObservableObject {
  private let repository: PlayerDataRepository
  private let videoPoker: PokerGame
  private let videoPokerStateManager: VideoPokerStateManager
  
  @Published private(set) var playerData: PlayerData
  @Published var betInput: String = ""
  @Published private(set) var currentHand: [Card] = []
  @Published var showPlayerInfo: Bool = false
  
  var lastSevenDays: [(date: Date, hasWin: Bool)] {
    let calendar = Calendar.current
    let today = Date()
    
    return Array(
      (0..<8)
        .compactMap { dayOffset in
          calendar.date(byAdding: .day, value: -dayOffset, to: today)
        }
        .filter { day in
          day != today || playerData.hasWinningHand(on: day)
        }
        .map { day in
          (date: day, hasWin: playerData.hasWinningHand(on: day))
        }
        .reversed()
        .suffix(7)
    )
  }
  
  var bestCardRank: String {
    playerData.bestCardRank?.name ?? "Unknown"
  }
  
  var bestHandRank: String {
    playerData.bestHandRank?.name ?? "Unknown"
  }
  
  var bestHandDate: Date? {
    playerData.bestHandDate
  }
  
  var biggestWin: String {
    guard let biggestWin = playerData.biggestWin else { return "Unknown" }
    return String(biggestWin)
  }
  
  var biggestWinDate: Date? {
    playerData.biggestWinDate
  }
  
  var currentBetString: String {
    guard let currentBet = playerData.currentBet else { return "Unknown" }
    return String(currentBet)
  }
  
  var expertMode: Bool {
    get { playerData.expertMode ?? false }
    set {
      var updatedData = playerData
      updatedData.expertMode = newValue
      playerData = updatedData
      repository.savePlayerData(playerData)
    }
  }
  
  var firstWinningHandDate: Date? {
    playerData.firstWinningHandDate
  }
  
  var handName: String {
    videoPoker.getHandName()
  }
  
  var handState: HandState {
    videoPokerStateManager.currentState
  }
  
  var isBetSet: Bool {
    playerData.currentBet != nil
  }
  
  var language: String {
    playerData.language ?? String()
  }
  
  var laterality: Laterality {
    get { playerData.laterality ?? .right }
    set {
      var updatedData = playerData
      updatedData.laterality = newValue
      playerData = updatedData
      repository.savePlayerData(playerData)
    }
  }
  
  var pokerLevel: PokerLevel {
    PlayerLevelDetermination.determinePlayerLevel(playerData: playerData)
  }
  
  var successfulBets: Int {
    playerData.successfulBets
  }
  
  var totalBets: Int {
    playerData.totalBets
  }
  
  var totalHandsPlayed: Int {
    playerData.totalHandsPlayed
  }
  
  var totalPoints: Int {
    playerData.totalPoints
  }
  
  var winningHands: Int {
    playerData.winningHands
  }
  
  var winnings: Int {
    videoPoker.winnings
  }
  
  init(videoPoker: PokerGame, repository: PlayerDataRepository) {
    self.repository = repository
    self.videoPoker = videoPoker
    self.videoPokerStateManager = VideoPokerStateManager(initialState: .initializing)
    self.playerData = repository.loadPlayerData()
  }
  
  func setBet(_ bet: String) {
    guard let betValue = Int(bet) else { return }
    let validBet = min(max(betValue, 1), playerData.totalPoints)
    
    playerData.currentBet = validBet
    repository.savePlayerData(playerData)
    
    betInput = ""
    updateInfos()
    
    guard videoPokerStateManager.currentState == .initializing else {
      return
    }
    
    videoPokerStateManager.transition(to: .finalHand, isBetSet)
  }
  
  func exchangeSelectedCards(indices: [Int]) {
    guard
      videoPokerStateManager.currentState != .initializing,
      videoPokerStateManager.currentState == .initialHand
    else {
      return
    }
    
    currentHand = videoPoker.exchangeCards(indices: indices)
    videoPoker.evaluateAndStoreHand(playerData: &playerData)
    repository.savePlayerData(playerData)
    updateInfos()
    videoPokerStateManager.transition(to: .finalHand, isBetSet)
  }
  
  func startNewRound() {
    guard
      videoPokerStateManager.currentState != .initializing,
      videoPokerStateManager.currentState == .finalHand
    else {
      return
    }
    
    videoPoker.pay(playerData: &playerData)
    repository.savePlayerData(playerData)
    updateInfos()
    videoPokerStateManager.transition(to: .initialHand, isBetSet)
  }
  
  private func updateInfos() {
    currentHand = videoPoker.currentHand
  }
}

// MARK: - Date Formatting
extension VideoPokerViewModel {
  private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .medium
    return formatter
  }
  
  func formatDate(_ date: Date?) -> String {
    guard let date = date else { return "Unknown" }
    return dateFormatter.string(from: date).localizedCapitalized
  }
  
  func formatDate(_ date: Date, style: DateFormatter.Style) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
  
  func dayForDate(_ date: Date) -> Day {
    let calendar = Calendar.current
    let weekday = calendar.component(.weekday, from: date)
    
    switch weekday {
      case 1: return .sunday
      case 2: return .monday
      case 3: return .tuesday
      case 4: return .wednesday
      case 5: return .thursday
      case 6: return .friday
      case 7: return .saturday
      default: fatalError("Invalid day")
    }
  }
}
