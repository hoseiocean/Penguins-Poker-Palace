//
//  PlayerInfoView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 10/10/2024.
//

import SwiftUI


struct PlayerInfoView: View {
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
        
        Section(header: Text("General Info")) {
          Text("Total Points: \(viewModel.totalPoints)")
          VStack(alignment: .leading) {
            Text("Best Hand: \(viewModel.bestHand)")
              .font(.body)
            Text(viewModel.formattedBestHandDate.capitalized)
              .font(.caption)
              .foregroundColor(.gray)
          }
          Text("First Winning Hand Date: \(viewModel.firstWinningHandDate)")
        }
        
        Section(header: Text("Game Stats")) {
          Text("Total Hands Played: \(viewModel.totalHandsPlayed)")
          Text("Winning Hands: \(viewModel.winningHands)")
          Text("Total Bets: \(viewModel.totalBets)")
          Text("Successful Bets: \(viewModel.successfulBets)")
          Text("Poker Level: \(viewModel.pokerLevel)")
        }
        
        Section(header: Text("Preferences")) {
          Toggle(isOn: $viewModel.expertMode) {
            Label("Expert Mode", systemImage: "medal.fill")
              .labelStyle(ColorfulIconLabelStyle(color: .blue))
          }
          Label("Language: \(viewModel.language)", systemImage: "globe")
            .labelStyle(ColorfulIconLabelStyle(color: .blue))
          Label("Laterality: \(viewModel.laterality)", systemImage: "hand.raised.fill")
            .labelStyle(ColorfulIconLabelStyle(color: .blue))
        }
      }
      .navigationTitle("Information")
    }
  }
}
