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
    .cornerRadius(8)
    .shadow(radius: 5)
  }
}

#Preview {
  CardView(card: RandomCardFactory().createRandomCard(), isSelected: false)
}
