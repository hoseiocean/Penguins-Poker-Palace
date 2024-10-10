//
//  VideoPokerApp.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI

@main
struct VideoPokerApp: App {
  
  @StateObject private var viewModel: VideoPokerViewModel

  var body: some Scene {
    WindowGroup {
      VideoPokerView(viewModel: viewModel)
    }
  }
  
  init () {
    let repository = UserDefaultsPlayerDataRepository()
    let playerData = repository.loadPlayerData() ?? PlayerData(
      beginnerMode: true,
      bestHand: .none,
      bestHandDate: Date(),
      currentBet: nil,
      firstWinningHandDate: nil,
      language: Locale.current.language.languageCode?.identifier ?? "en",
      laterality: .rightHanded,
      totalPoints: 100
    )
    let game = VideoPokerGame(deck: Deck(), playerData: playerData)

    _viewModel = StateObject(wrappedValue: VideoPokerViewModel(game: game, repository: repository))
  }
}
