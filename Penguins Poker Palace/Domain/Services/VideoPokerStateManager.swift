//
//  VideoPokerStateManager.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 16/10/2024.
//


class VideoPokerStateManager {
  private(set) var currentState: HandState = .initializing
  
  init(initialState: HandState) {
    self.currentState = initialState
  }
  
  private func canTransition(to newState: HandState, _ isBetSet: Bool) -> Bool {
    guard isBetSet else { return false }
    return switch (currentState, newState) {
      case (.initializing, .initialHand):
        true
      case (.initializing, .finalHand):
        true
      case (.initialHand, .finalHand):
        true
      case (.finalHand, .initialHand):
        true
      default:
        false
    }
  }
  
  func transition(to newState: HandState, _ isBetSet: Bool) {
    guard canTransition(to: newState, isBetSet) else {
      print("Invalid state transition: \(currentState) to \(newState)")
      return
    }
    currentState = newState
  }
}
