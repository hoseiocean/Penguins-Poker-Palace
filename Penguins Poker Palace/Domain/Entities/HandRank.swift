//
//  HandRank.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


enum HandRank: Int {
  case none, onePair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush
}

extension HandRank {

  var name: String {
    switch self {
      case .none: String(localized: "hand_none")
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
  
  var winnings: Int {
    switch self {
      case .royalFlush: 250
      case .straightFlush: 50
      case .fourOfAKind: 25
      case .fullHouse: 9
      case .flush: 6
      case .straight: 4
      case .threeOfAKind: 3
      case .twoPair: 2
      case .onePair: 1
      case .none: 0
    }
  }
  
  private static func areImmediatelyConsecutive(ranks: [Rank]) -> Bool {
    let sortedRanks = ranks.sorted()
    let consecutiveRanksPairs = zip(sortedRanks, sortedRanks.dropFirst())
    return consecutiveRanksPairs.allSatisfy { lowRank, highRank in lowRank.isImmediatlyFollowedBy(highRank) }
  }
  
  private static func containsWinningPair(in rankCounts: [Rank: Int]) -> Bool {
    if let pairRank = rankCounts.first(where: { rankCount in rankCount.value == 2 })?.key, pairRank >= .jack {
      return true
    }
    return false
  }
  
  static func evaluate(cards: [Card]) -> HandRank {
    let ranks = cards.map { card in card.rank }
    let suits = cards.map { card in card.suit }
    
    let sameRankCounts = Dictionary(ranks.map { rank in (rank, 1) }, uniquingKeysWith: +)
    let sameSuitCounts = Dictionary(suits.map { suit in (suit, 1) }, uniquingKeysWith: +)
    
    let isFlush = sameSuitCounts.values.contains(5)
    let isStraight = areImmediatelyConsecutive(ranks: ranks)
    
    return switch (isFlush, isStraight, sameRankCounts) {
      case (true, true, _) where ranks.max() == .ace && ranks.min() == .ten: .royalFlush
      case (true, true, _): .straightFlush
      case (_, _, let sameRanks) where sameRanks.values.contains(4): .fourOfAKind
      case (_, _, let sameRanks) where sameRanks.values.contains(3) && sameRanks.values.contains(2): .fullHouse
      case (true, _, _): .flush
      case (_, true, _): .straight
      case (_, _, let sameRanks) where sameRanks.values.contains(3): .threeOfAKind
      case (_, _, let sameRanks) where sameRanks.filter { rankCount in rankCount.value == 2 }.count == 2: .twoPair
      case (_, _, let sameRanks) where containsWinningPair(in: sameRanks): .onePair
      default: .none
    }
  }
}

extension HandRank: Comparable {
  public static func < (lhs: HandRank, rhs: HandRank) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
