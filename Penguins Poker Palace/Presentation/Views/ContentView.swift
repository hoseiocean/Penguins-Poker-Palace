//
//  ContentView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewModel: VideoPokerViewModel
  
  var body: some View {
    VStack {
      HStack {
        ForEach(viewModel.hand, id: \.self) { card in
          Text("\(card.rank.symbol)\(card.suit.emoji)")
        }
      }
      
      Text("Hand Rank: \(viewModel.handRank.rawValue)")
      
      Button(action: {
        viewModel.dealHand()
      }) {
        Text("Deal")
      }
    }
    .onAppear {
      viewModel.loadGame()
    }
  }
}

#Preview {
  let mockGame = MockVideoPokerGame()
  let mockRepository = MockGameRepository()
  let viewModel = VideoPokerViewModel(game: mockGame, repository: mockRepository)
  ContentView(viewModel: viewModel)
}
