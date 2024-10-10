//
//  VideoPokerView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI


struct VideoPokerView: View {
  @StateObject var viewModel: VideoPokerViewModel
  @State private var selectedCards: Set<Int> = []
  @State private var showingSheet = true
  
  var body: some View {
    VStack {
      if viewModel.handState != .initializing {
        HStack {
          ForEach(viewModel.currentHand.indices, id: \.self) { index in
            CardView(card: viewModel.currentHand[index], isSelected: selectedCards.contains(index))
              .onTapGesture {
                toggleCardSelection(at: index)
              }
          }
        }
        .padding()
        
        Text(viewModel.handState == .finalHand ? viewModel.handName : "")
          .font(.title2)
          .padding()
        
        HStack {
          Text("view_points: \(viewModel.totalPoints)")
            .font(.title3)
            .padding()
          Text("view_bet: \(viewModel.currentBet ?? 0)")
            .font(.title3)
            .padding()
          Text("view_winnings: \(viewModel.winnings)")
            .font(.title3)
            .padding()
        }
      } else {
        Text("view_points: \(viewModel.totalPoints)")
          .font(.title3)
          .padding()
      }
      
      HStack {
        TextField("view_set_your_bet:", text: $viewModel.betInput)
          .keyboardType(.numberPad)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .frame(width: 100)
          .padding()
        
        Button("button_ok") {
          if let bet = Int(viewModel.betInput) {
            viewModel.setBet(bet)
          }
        }
        .padding()
      }
      
      switch viewModel.handState {
        case .initializing:
          Text("view_initializing")
        case .initialHand:
          Button("button_confirm_selection") {
            viewModel.exchangeSelectedCards(indices: Array(selectedCards))
            selectedCards.removeAll()
          }
          .padding()
        case .finalHand:
          Button("button_new_game") {
            selectedCards.removeAll()
            viewModel.startNewRound()
          }
          .padding()
      }
      Button("Show Player Info") {
        showingSheet.toggle()
      }
      .padding()
    }
    .onAppear {
      viewModel.loadGameState()
    }
    .sheet(isPresented: $showingSheet) {
      PlayerInfoView(viewModel: viewModel)
        .presentationDetents([.fraction(0.2), .medium, .large])
        .presentationDragIndicator(.visible)
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

//#Preview {
//  let mockGame = MockVideoPokerGame(, playerData: PlayerData(totalPoints: <#Int#>, currentBet: <#Int#>, bestHand: <#HandRank#>, bestHandDate: <#Date#>, preferredLanguage: <#String#>, firstWinningHandDate: <#Date?#>, handPreference: <#HandPreference#>, pokerLevel: <#PokerLevel#>, beginnerMode: <#Bool#>))
//  let mockRepository = MockPlayerDataRepository()
//  let viewModel = VideoPokerViewModel(game: mockGame, repository: mockRepository)
//  VideoPokerView(viewModel: viewModel)
//}
