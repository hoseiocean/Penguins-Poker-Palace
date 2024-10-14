//
//  CardView.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//

import SwiftUI


struct CardView: View {
  let card: Card
  let isSelected: Bool
  
  var body: some View {
    VStack {
      Text(card.rank.symbol)
        .font(.largeTitle)
      Text(card.suit.emoji)
    }
    .padding()
    .background(isSelected ? Color.yellow : Color.white)
    .cornerRadius(8.0)
    .shadow(radius: 4.0)
  }
}

#Preview {
  CardView(card: RandomCardFactory().createRandomCard(), isSelected: Bool.random())
}
