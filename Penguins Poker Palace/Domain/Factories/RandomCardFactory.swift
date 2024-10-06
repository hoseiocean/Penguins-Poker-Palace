//
//  RandomCardFactory.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class RandomCardFactory: CardFactory {
  func createRandomCard() -> Card {
    let suits: [Suit] = [.hearts, .diamonds, .clubs, .spades]
    let randomSuit = suits.randomElement()!
    let randomRank = Rank(rawValue: Int.random(in: 2...14))!
    return Card(suit: randomSuit, rank: randomRank)
  }
}
