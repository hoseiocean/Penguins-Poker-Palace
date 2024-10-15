//
//  Deck.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


final class Deck {
  private var cards: [Card] = []
  
  init() {
    self.generate()
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
    cards.isEmpty ? nil : cards.removeLast()
  }
  
  func drawCards(_ requestedQuantity: Int) -> [Card] {
    let quantity = min(requestedQuantity, cards.count) // to avoid taking more cards than available
    let drawnCards = cards.suffix(quantity)
    cards.removeLast(quantity)
    return Array(drawnCards)
  }
  
  func reset() {
    self.generate()
  }
}
