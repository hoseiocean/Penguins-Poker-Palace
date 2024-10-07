//
//  MockVideoPokerGame.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class MockVideoPokerGame: VideoPokerGame {
  var deck: Deck
  var handState: HandState

  override init(deck: Deck = .init(), currentHand: [Card] = [], handState: HandState = .initialHand) {
    self.deck = deck
    self.handState = handState
    super.init(deck: deck)
  }
  
  override func dealHand() -> [Card] {
    [
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard(),
      RandomCardFactory().createRandomCard()
    ]
  }
  
  override func evaluateHand() -> HandRank {
    .royalFlush
  }
}
