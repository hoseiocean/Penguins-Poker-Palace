//
//  InformationView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 10/10/2024.
//

import SwiftUI


struct DayWinningStatus: Hashable {
  let date: Date
  let hasWinningHand: Bool
}
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
        
        Section(header: Text("info_last_7_days")) {
          HStack {
            ForEach(viewModel.lastSevenDays, id: \.self) { day in
              VStack(alignment: .center) {
                Text(day.hasWinningHand ? "🐧" : "")
                Text(viewModel.dayForDate(day.date).rawValue)
              }
            }
            .frame(maxWidth: .infinity)
          }
          .frame(maxWidth: .infinity)
        }
        
        Section(header: Text("info_general_info")) {
          Text("info_total_points: \(String(describing: viewModel.totalPoints))")
          VStack(alignment: .leading) {
            Text("info_biggest_win: \(viewModel.biggestWin)")
              .font(.body)
            Text(viewModel.formatDate(viewModel.biggestWinDate))
              .font(.caption)
              .foregroundColor(.gray)
          }
          VStack(alignment: .leading) {
            Text("info_best_hand: \(viewModel.bestHandRank) / \(viewModel.bestCardRank)")
              .font(.body)
            Text(viewModel.formatDate(viewModel.bestHandDate))
              .font(.caption)
              .foregroundColor(.gray)
          }
          Text("info_first_winning_hand_date: \(viewModel.formatDate(viewModel.firstWinningHandDate))")
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

#Preview {
  let calendar = Calendar.current
  let today = Date()
  let lastSevenDays = Set((0..<7).map { calendar.date(byAdding: .day, value: -$0, to: today)! })
  
  let testPlayerData = PlayerData(
    bestCardRank: .ace,
    bestHandRank: .royalFlush,
    bestHandDate: Date(),
    currentBet: 50,
    dailyWinningHistory: lastSevenDays,
    expertMode: true,
    firstWinningHandDate: Date(),
    language: "en",
    laterality: .right,
    successfulBets: 10,
    totalBets: 20,
    totalHandsPlayed: 100,
    totalPoints: 1000,
    winningHands: 30
  )
  
  let testGame = VideoPoker(deck: Deck(), playerData: testPlayerData)
  let testViewModel = VideoPokerViewModel(videoPoker: testGame, repository: UserDefaultsPlayerDataRepository(), videoPokerStateManager: .init(initialState: .initializing))
  
  InformationView(viewModel: testViewModel)
}
