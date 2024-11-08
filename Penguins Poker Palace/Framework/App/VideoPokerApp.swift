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
  
  init() {
    let repository = UserDefaultsPlayerDataRepository()
    let pokerGame = PokerGame(deck: Deck())
    _viewModel = StateObject(wrappedValue: VideoPokerViewModel(videoPoker: pokerGame, repository: repository))
  }
  
  let initialDailyWinningHistory: Set<Date> = {
    let calendar = Calendar.current
    let today = Date()
    return Set((1..<8).compactMap { calendar.date(byAdding: .day, value: -$0, to: today) })
  }()
}
