//
//  Day.swift
//  Penguins Poker Palace
//
//  Created by Thomas Heinis on 24/10/2024.
//


enum Day {
  case friday
  case monday
  case saturday
  case sunday
  case thursday
  case tuesday
  case wednesday
  
  var short: String {
    switch self {
      case .friday: String(localized: String.LocalizationValue("day_short_friday"))
      case .monday: String(localized: String.LocalizationValue("day_short_monday"))
      case .saturday: String(localized: String.LocalizationValue("day_short_saturday"))
      case .sunday: String(localized: String.LocalizationValue("day_short_sunday"))
      case .thursday: String(localized: String.LocalizationValue("day_short_thursday"))
      case .tuesday: String(localized: String.LocalizationValue("day_short_tuesday"))
      case .wednesday: String(localized: String.LocalizationValue("day_short_wednesday"))
    }
  }
}
