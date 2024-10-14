//
//  CaseIterable+randomCase.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 11/10/2024.
//


extension CaseIterable where Self: Equatable {
  static func randomCase() -> Self {
    allCases.randomElement()!
  }
}
