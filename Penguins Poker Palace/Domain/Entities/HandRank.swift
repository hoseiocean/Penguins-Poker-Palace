//
//  HandRank.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


enum HandRank: Int {
  case highCard, onePair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush
  
  var name: String {
    switch self {
      case .highCard: String(localized: "hand_high_card")
      case .onePair: String(localized: "hand_one_pair")
      case .twoPair: String(localized: "hand_two_pair")
      case .threeOfAKind: String(localized: "hand_three_of_a_kind")
      case .straight: String(localized: "hand_straight")
      case .flush: String(localized: "hand_flush")
      case .fullHouse: String(localized: "hand_full_house")
      case .fourOfAKind: String(localized: "hand_four_of_a_kind")
      case .straightFlush: String(localized: "hand_straight_flush")
      case .royalFlush: String(localized: "hand_royal_flush")
    }
  }
  
  private static func isConsecutive(ranks: [Int]) -> Bool {
    let sortedRanks = ranks.sorted()
    for i in 1..<sortedRanks.count {
      if sortedRanks[i] != sortedRanks[i - 1] + 1 {
        return false
      }
    }
    return true
  }
  
  static func evaluate(cards: [Card]) -> HandRank {
    let ranks = cards.map { card in card.rank.rawValue }
    let suits = cards.map { card in card.suit }
    
    let rankCounts = Dictionary(ranks.map { rank in (rank, 1) }, uniquingKeysWith: +)
    let suitCounts = Dictionary(suits.map { suit in (suit, 1) }, uniquingKeysWith: +)
    
    let isFlush = suitCounts.values.contains(5)
    let isStraight = isConsecutive(ranks: ranks)
    
    switch (isFlush, isStraight, rankCounts) {
    case (true, true, _) where ranks.max() == Rank.ace.rawValue && ranks.min() == 10:
        return .royalFlush
    case (true, true, _):
        return .straightFlush
    case (_, _, let rankCounts) where rankCounts.values.contains(4):
        return .fourOfAKind
    case (_, _, let rankCounts) where rankCounts.values.contains(3) && rankCounts.values.contains(2):
        return .fullHouse
    case (true, _, _):
        return .flush
    case (_, true, _):
        return .straight
    case (_, _, let rankCounts) where rankCounts.values.contains(3):
        return .threeOfAKind
    case (_, _, let rankCounts) where rankCounts.filter { $0.value == 2 }.count == 2:
        return .twoPair
    case (_, _, let rankCounts) where rankCounts.values.contains(2):
        return .onePair
    default:
        return .highCard
    }
  }
}
