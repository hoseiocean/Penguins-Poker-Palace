//
//  VideoPokerStateManager.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 16/10/2024.
//


class VideoPokerStateManager {
  var currentState: HandState
  
  init(initialState: HandState) {
    self.currentState = initialState
  }
  
  func canTransition(to newState: HandState, with bet: Int?) -> Bool {
    switch (currentState, newState) {
      case (.initialHand, .finalHand):
        true
      case (.initializing, .initialHand):
        bet != nil
      case (.finalHand, .initialHand):
        true
      default:
        false
    }
  }
  
  func transition(to newState: HandState, with bet: Int?) {
    guard canTransition(to: newState, with: bet) else {
      print("Invalid state transition: \(currentState) to \(newState)")
      return
    }
    currentState = newState
  }
}
