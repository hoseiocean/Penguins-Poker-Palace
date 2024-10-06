//
//  Deck.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


class Deck {
  private var cards: [Card] = []
  
  init() {
    generateDeck()
  }
  
  private func generateDeck() {
    cards.removeAll()
    
    cards = Suit.allCases.flatMap { suit in
      Rank.allCases.map { rank in
        Card(suit: suit, rank: rank)
      }
    }
    
    shuffleDeck()
  }
  
  func shuffleDeck() {
    cards.shuffle()
  }
  
  func dealCard() -> Card? {
    return cards.isEmpty ? nil : cards.removeLast()
  }
  
  func reset() {
    generateDeck()
  }
}
