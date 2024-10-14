//
//  ColorfulIconLabelStyle.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 11/10/2024.
//

import SwiftUI


struct ColorfulIconLabelStyle: LabelStyle {
  var color: Color = .blue
  
  func makeBody(configuration: Configuration) -> some View {
    Label {
      configuration
        .title
    } icon: {
      configuration
        .icon
        .font(.system(size: 14.0))
        .foregroundColor(.white)
        .background(
          RoundedRectangle(cornerRadius: 8.0)
            .frame(width: 28.0, height: 28.0)
            .foregroundColor(color)
        )
    }
  }
}
