//
//  MockVideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class MockVideoPokerGame: VideoPoker {
  var deck: Deck

  override init(deck: Deck = .init(), playerData: PlayerData) {
    self.deck = deck
    super.init(deck: deck, playerData: playerData)
  }
  
  func dealHand() -> [Card] {
    [
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard()
    ]
  }
}
