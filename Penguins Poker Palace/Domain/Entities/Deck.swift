//
//  Deck.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


final class Deck {
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
    cards.isEmpty ? nil : cards.removeLast()
  }
  
  func drawCards(_ requestedQuantity: Int) -> [Card] {
    let count = min(requestedQuantity, cards.count)
    let drawnCards = Array(cards.suffix(count))
    cards.removeLast(count)
    return drawnCards
  }
  
  func reset() {
    self.generate()
  }
}
