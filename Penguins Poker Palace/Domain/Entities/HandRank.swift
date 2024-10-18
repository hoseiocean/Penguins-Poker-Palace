//
//  HandRank.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


enum HandRank: Int {
  case none, onePair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush

  var name: String {
    switch self {
      case .royalFlush: String(localized: "hand_royal_flush")
      case .straightFlush: String(localized: "hand_straight_flush")
      case .fourOfAKind: String(localized: "hand_four_of_a_kind")
      case .fullHouse: String(localized: "hand_full_house")
      case .flush: String(localized: "hand_flush")
      case .straight: String(localized: "hand_straight")
      case .threeOfAKind: String(localized: "hand_three_of_a_kind")
      case .twoPair: String(localized: "hand_two_pair")
      case .onePair: String(localized: "hand_one_pair")
      case .none: String(localized: "hand_none")
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
    let consecutiveRanksIntervals = zip(sortedRanks, sortedRanks.dropFirst())
    return consecutiveRanksIntervals.allSatisfy { lowRank, highRank in lowRank.isImmediatlyFollowedBy(highRank) }
  }
  
  private static func containsWinningPair(in rankCounts: [Rank: Int]) -> Bool {
    if let pairRank = rankCounts.first(where: { rankCount in rankCount.value == 2 })?.key, pairRank >= .jack {
      return true
    }
    return false
  }
  
  static func evaluate(cards: [Card]) -> HandEvaluation {
    let ranks = cards.map { card in card.rank }
    let suits = cards.map { card in card.suit }
    
    let sameRankCounts = Dictionary(ranks.map { rank in (rank, 1) }, uniquingKeysWith: +)
    let sameSuitCounts = Dictionary(suits.map { suit in (suit, 1) }, uniquingKeysWith: +)
    
    let isFlush = sameSuitCounts.values.contains(5)
    let isStraight = areImmediatelyConsecutive(ranks: ranks)
    
    switch (isFlush, isStraight, sameRankCounts) {
      case (true, true, _) where ranks.max() == .ace && ranks.min() == .ten:
        let highestCard = cards.first { $0.rank == .ace }!.rank
        return (.royalFlush, highestCard)
        
      case (true, true, _):
        let highestCard = cards.max(by: { $0.rank < $1.rank })!.rank
        return (.straightFlush, highestCard)
        
      case (_, _, let sameRanks) where sameRanks.values.contains(4):
        let highestCard = cards.first { sameRanks[$0.rank] == 4 }!.rank
        return (.fourOfAKind, highestCard)
        
      case (_, _, let sameRanks) where sameRanks.values.contains(3) && sameRanks.values.contains(2):
        let highestCard = cards.first { sameRanks[$0.rank] == 3 }!.rank
        return (.fullHouse, highestCard)
        
      case (true, _, _):
        let highestCard = cards.max(by: { $0.rank < $1.rank })!.rank
        return (.flush, highestCard)
        
      case (_, true, _):
        let highestCard = cards.max(by: { $0.rank < $1.rank })!.rank
        return (.straight, highestCard)
        
      case (_, _, let sameRanks) where sameRanks.values.contains(3):
        let highestCard = cards.first { sameRanks[$0.rank] == 3 }!.rank
        return (.threeOfAKind, highestCard)
        
      case (_, _, let sameRanks) where sameRanks.filter { $0.value == 2 }.count == 2:
        let highestCard = cards.first { sameRanks[$0.rank] == 2 }!.rank
        return (.twoPair, highestCard)
        
      case (_, _, let sameRanks) where containsWinningPair(in: sameRanks):
        let pairRank = sameRanks.filter { $0.value == 2 }.keys.max()!
        let highestCard = cards.first { $0.rank == pairRank }!.rank
        return (.onePair, highestCard)
        
      default:
        let highestCard = cards.max(by: { $0.rank < $1.rank })!.rank
        return (.none, highestCard)
    }
  }
}

extension HandRank: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
