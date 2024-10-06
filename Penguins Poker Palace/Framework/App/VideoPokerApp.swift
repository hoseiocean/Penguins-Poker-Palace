//
//  VideoPokerApp.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI

@main
struct VideoPokerApp: App {
  var body: some Scene {
    WindowGroup {
      let repository = InMemoryGameRepository()
      let game = VideoPokerGame(deck: Deck())
      let viewModel = VideoPokerViewModel(game: game, repository: repository)
      ContentView(viewModel: viewModel)
    }
  }
}
