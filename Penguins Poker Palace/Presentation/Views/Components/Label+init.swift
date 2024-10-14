//
//  Label+init.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 11/10/2024.
//

import SwiftUI


extension Label where Title == Text, Icon == Image {
  init(_ title: String, icon name: IconName) {
    self.init(title, systemImage: name.rawValue)
  }
}

#Preview {
  Label("Hello, World!", icon: .randomCase())
}
