//
//  ContentView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewModel: VideoPokerViewModel
  
  @State private var selectedCards: Set<Int> = []
  
  var body: some View {
    VStack {
      HStack {
        ForEach(0..<viewModel.currentHand.count, id: \.self) { index in
          CardView(card: viewModel.currentHand[index], isSelected: selectedCards.contains(index))
            .onTapGesture {
              toggleCardSelection(at: index)
            }
        }
      }
      .padding()
      
      Text(viewModel.handName)
        .font(.title2)
        .padding()
      
      Button("button_exchange_cards") {
        viewModel.exchangeSelectedCards(indices: Array(selectedCards))
        selectedCards.removeAll()
      }
      .padding()
      .disabled(selectedCards.isEmpty)
      
      Button("button_new_game") {
        viewModel.resetGame()
        selectedCards.removeAll()
      }
      .padding()
    }
    .onAppear {
      viewModel.dealHand()
    }
  }
  
  private func toggleCardSelection(at index: Int) {
    if selectedCards.contains(index) {
      selectedCards.remove(index)
    } else {
      selectedCards.insert(index)
    }
  }
}

#Preview {
  let mockGame = MockVideoPokerGame()
  let mockRepository = MockGameRepository()
  let viewModel = VideoPokerViewModel(game: mockGame, repository: mockRepository)
  ContentView(viewModel: viewModel)
}
