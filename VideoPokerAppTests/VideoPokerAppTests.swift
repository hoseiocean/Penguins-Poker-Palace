//
//  VideoPokerAppTests.swift
//  VideoPokerAppTests
//
//  Created by Thomas Heinis on 06/10/2024.
//

import XCTest
@testable import Penguins_Poker_Palace

class VideoPokerAppTests: XCTestCase {
  
  let testPlayerData = PlayerData(
    bestHand: .royalFlush,
    bestHandDate: Date(),
    currentBet: 100,
    expertMode: true,
    firstWinningHandDate: Date(),
    language: "en",
    laterality: .right,
    successfulBets: 5,
    totalBets: 10,
    totalHandsPlayed: 50,
    totalPoints: 500,
    winningHands: 20
  )
  
  func testDealHand() {
    // Given
    let mockGame = MockVideoPokerGame(playerData: testPlayerData)
    let mockRepository = MockPlayerDataRepository()
    let viewModel = VideoPokerViewModel(game: mockGame, repository: mockRepository)
    
    // When
    viewModel.startNewRound()
    
    // Then
    XCTAssertEqual(viewModel.currentHand.count, 5, "The hand should contain 5 cards")
  }
}
