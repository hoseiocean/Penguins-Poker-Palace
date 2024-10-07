//
//  RandomCardFactory.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


final class RandomCardFactory: CardFactory {
  func createRandomCard() -> Card {
    let randomRank = Rank.allCases.randomElement()!
    let randomSuit = Suit.allCases.randomElement()!
    return Card(suit: randomSuit, rank: randomRank)
  }
}
