//
//  ColorfulIconLabelStyle.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 11/10/2024.
//

import SwiftUI


struct ColorfulIconLabelStyle: LabelStyle {
  var color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    Label {
      configuration
        .title
    } icon: {
      configuration
        .icon
        .font(.system(size: 14))
        .foregroundColor(.white)
        .background(
          RoundedRectangle(cornerRadius: 7)
            .frame(width: 28, height: 28)
            .foregroundColor(color)
        )
    }
  }
}
