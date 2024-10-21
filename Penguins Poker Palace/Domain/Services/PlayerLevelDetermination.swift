//
//  PlayerLevelDetermination.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//


class PlayerLevelDetermination {
  
  static func determinePlayerLevel(playerData: PlayerData) -> PokerLevel {
    guard playerData.totalHandsPlayed > 50 else { return .newbie }
    
    return switch (playerData.ratioOfSuccessHandsAtPoker, playerData.ratioOfSuccessTriesAtBet) {
      case let (poker, bet) where poker < 0.5 && bet < 0.5 && poker < bet: .donkey
      case let (poker, bet) where poker < 0.5 && bet < 0.5 && bet <= poker: .fish
      case let (poker, bet) where bet >= 0.5 && bet >= poker: .whale
      case let (poker, bet) where poker >= 0.5 && poker >= bet: .shark
      default: .mass
    }
  }
}
