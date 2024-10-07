//
//  Deck.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class Deck {
  private var cards: [Card] = []
  
  init() {
    generate()
  }
  
  private func generate() {
    cards.removeAll()
    
    cards = Suit.allCases.flatMap { suit in
      Rank.allCases.map { rank in
        Card(suit: suit, rank: rank)
      }
    }

    cards.shuffle()
  }
  
  func dealCard() -> Card? {
    drawCards(1).first
  }
  
  func drawCards(_ requestedQuantity: Int) -> [Card] {
    let requestedCards = Array(cards.prefix(requestedQuantity))
    cards.removeFirst(min(requestedQuantity, cards.count))
    return requestedCards
  }
  
  func reset() {
    self.generate()
  }
}
