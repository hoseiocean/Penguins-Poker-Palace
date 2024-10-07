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
      let game = VideoPokerGame(deck: Deck())
      let repository = InMemoryGameRepository()
      let viewModel = VideoPokerViewModel(game: game, repository: repository)
      VideoPokerView(viewModel: viewModel)
    }
  }
}
