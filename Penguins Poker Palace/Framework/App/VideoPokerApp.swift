//
//  VideoPokerApp.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI

@main
struct VideoPokerApp: App {
  
  private let videoPokerStateManager: VideoPokerStateManager
  
  @StateObject private var viewModel: VideoPokerViewModel

  var body: some Scene {
    WindowGroup {
      VideoPokerView(viewModel: viewModel)
    }
  }
  
  init () {
    let repository = UserDefaultsPlayerDataRepository()
    let playerData = repository.loadPlayerData() ?? PlayerData(
      bestHand: Optional.none,
      bestHandDate: Date(),
      currentBet: nil,
      expertMode: true,
      firstWinningHandDate: nil,
      language: Locale.current.language.languageCode?.identifier ?? "en",
      laterality: .right,
      totalPoints: 100
    )
    videoPokerStateManager = VideoPokerStateManager(initialState: .initializing)
    let videoPoker = VideoPoker(deck: Deck(), playerData: playerData, videoPokerStateManager: videoPokerStateManager)

    _viewModel = StateObject(wrappedValue: VideoPokerViewModel(videoPoker: videoPoker, repository: repository, videoPokerStateManager: VideoPokerStateManager(initialState: .initializing)))
  }
}
