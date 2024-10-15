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
          Text("view_bet: \(viewModel.currentBetString)")
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
          .onChange(of: viewModel.betInput) {
            viewModel.betInput = viewModel.betInput.filter { input in input.isNumber }
          }
        Button("button_ok") {
          viewModel.setBet(viewModel.betInput)
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
      Button("button_show_information") {
        showingSheet.toggle()
      }
      .padding()
    }
    .onAppear {
      viewModel.loadGameState()
    }
    .sheet(isPresented: $showingSheet) {
      InformationView(viewModel: viewModel)
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

#Preview {
  let testPlayerData = PlayerData(
    bestHand: .royalFlush,
    bestHandDate: Date(),
    currentBet: 100,
    expertMode: true,
    firstWinningHandDate: Date(),
    language: "en",
    laterality: .right,
    successfulBets: 5,
    totalBets: 10,
    totalHandsPlayed: 50,
    totalPoints: 500,
    winningHands: 20
  )
  
  let mockGame = MockVideoPokerGame(playerData: testPlayerData)
  let mockRepository = MockPlayerDataRepository()
  let viewModel = VideoPokerViewModel(game: mockGame, repository: mockRepository)

  VideoPokerView(viewModel: viewModel)
}
