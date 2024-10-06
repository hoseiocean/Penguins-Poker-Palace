//
//  VideoPokerAppTests.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 06/10/2024.
//


import XCTest
@testable import VideoPokerApp

class VideoPokerAppTests: XCTestCase {
  
  func testDealHand() {
    // Given
    let mockGame = MockVideoPokerGame()
    let mockRepository = MockGameRepository()
    let viewModel = VideoPokerViewModel(game: mockGame, repository: mockRepository)
    
    // When
    viewModel.dealHand()
    
    // Then
    XCTAssertEqual(viewModel.hand.count, 5, "The hand should contain 5 cards")
    XCTAssertEqual(viewModel.handRank, .royalFlush, "The hand rank should be Royal Flush")
  }
}
