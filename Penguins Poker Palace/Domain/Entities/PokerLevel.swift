//
//  PokerLevel.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 09/10/2024.
//


enum PokerLevel {
  case donkey
  case fish
  case mass
  case shark
  case whale
}

extension PokerLevel {
  
  var description: String {
    switch self {
      case .donkey: "You're a donkey! Your poker game is the weakest, but you also don't fare well in betting."
      case .fish: "You're a fish! You struggle with both poker and betting, especially with the latter."
      case .mass: "No poker level assigned yet. Keep playing to define your level!"
      case .shark: "You're a shark! You've mastered poker and consistently outplay others."
      case .whale: "You're a whale! You take big risks in betting and often come out on top."
    }
  }
  
  var emoji: String {
    switch self {
      case .donkey: "🐴"
      case .fish: "🐟"
      case .mass: "❓"
      case .shark: "🦈"
      case .whale: "🐋"
    }
  }
  
  var name: String {
    switch self {
      case .donkey: "Donkey"
      case .fish: "Fish"
      case .mass: "Mass"
      case .shark: "Shark"
      case .whale: "Whale"
    }
  }
}
