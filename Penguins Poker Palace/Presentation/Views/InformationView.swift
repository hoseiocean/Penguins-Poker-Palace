//
//  InformationView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 10/10/2024.
//

import SwiftUI


struct InformationView: View {
  @ObservedObject var viewModel: VideoPokerViewModel
  
  var body: some View {
    NavigationView {
      List {
        
        Section {
          VStack(alignment: .center) {
            Text(viewModel.pokerLevel.emoji)
              .font(.system(size: 72.0))
            Text(viewModel.pokerLevel.name)
              .font(.title2)
              .bold()
            Text(viewModel.pokerLevel.description)
          }
          .padding()
        }
        
        Section(header: Text("info_general_info")) {
          Text("info_total_points: \(String(describing: viewModel.totalPoints))")
          VStack(alignment: .leading) {
            Text("info_biggest_win: \(viewModel.biggestWin)")
              .font(.body)
            Text(viewModel.biggestWinDate)
              .font(.caption)
              .foregroundColor(.gray)
          }
          VStack(alignment: .leading) {
            Text("info_best_hand: \(viewModel.bestHand)")
              .font(.body)
            Text(viewModel.bestHandDate)
              .font(.caption)
              .foregroundColor(.gray)
          }
          Text("info_first_winning_hand_date: \(viewModel.firstWinningHandDate)")
        }
        
        Section(header: Text("info_game_stats")) {
          Text("info_total_hands_played: \(viewModel.totalHandsPlayed)")
          Text("info_winning_hands: \(viewModel.winningHands)")
          Text("info_total_bets: \(viewModel.totalBets)")
          Text("info_successful_bets: \(viewModel.successfulBets)")
        }
        
        Section(header: Text("info_preferences")) {
          Toggle(isOn: $viewModel.expertMode) {
            Label("info_expert_mode", icon: .medal)
              .labelStyle(ColorfulIconLabelStyle(color: .blue))
          }
          Label("info_language", icon: .globe)
            .labelStyle(ColorfulIconLabelStyle(color: .blue))
          
          HStack {
            Label("info_laterality:", icon: .hand)
              .labelStyle(ColorfulIconLabelStyle(color: .blue))
            
            Picker("info_laterality:", selection: $viewModel.laterality) {
              Text("info_left").tag(1)
              Text("info_right").tag(2)
            }
            .pickerStyle(.segmented)
          }
        }
      }
      .navigationTitle("info_information")
    }
  }
}

//#Preview {
//  let testPlayerData = PlayerData(
//    bestHand: .royalFlush,
//    bestHandDate: Date(),
//    currentBet: 50,
//    expertMode: true,
//    firstWinningHandDate: Date(),
//    language: "en",
//    laterality: .right,
//    successfulBets: 10,
//    totalBets: 20,
//    totalHandsPlayed: 100,
//    totalPoints: 1000,
//    winningHands: 30
//  )
//  
//  let testGame = VideoPoker(deck: Deck(), playerData: testPlayerData)
//  let testViewModel = VideoPokerViewModel(videoPoker: testGame, repository: UserDefaultsPlayerDataRepository())
//  
//  InformationView(viewModel: testViewModel)
//}
