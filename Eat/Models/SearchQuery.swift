//
//  SearchQuery.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

enum MealTime {
  case now
  case later(date: Date)
}

enum DietaryRestrictions {
  case vegan, vegetarian, halal, none

  var keyword: String? {
    switch self {
    case .vegan: return "vegan"
    case .vegetarian: return "vegetarian"
    case .halal: return "halal"
    case .none: return nil
    }
  }
}

class SearchQuery {
  // Map
  var latitude: Float = 49.2827 // Latitude of the restaurant
  var longitude: Float = 123.1207 // Longitude of the restaurant.
  var radius: Int = 890 // Radius of search. Ssearch area is in METERS

  // People Count
  var numberOfPeople = 1

  // Eating Time
  var mealTime: MealTime = .now

  // Rating and Price
  var minimumRating: Double = 3
  var price: [Int] = [] // Matches one of "$", "$$" or "$$$" ($ = 1, $$ = 2, $$$ = 3)

  // Dietary Restrictions
  var dietary: DietaryRestrictions = .none
  var searchTerm: String = ""
}

extension SearchQuery {
  var numberOfRestaurants: Int {
    switch numberOfPeople {
    case 1, 2:    return 4
    case 3, 4:    return 6
    case 5:       return 8
    case 6:       return 9
    case 7:       return 11
    case 8:       return 12
    case 9:       return 13
    case 10:      return 15
    default:      return 0
    }
  }

  var priceString: String {
    if price.isEmpty {
      return "1,2,3,4"
    } else {
      var returnPrice = price.map { String($0) }.joined(separator: ",")
      // If user selected highest price value available, give them the most
      // expensive restaurants too
      if price.contains(3) { returnPrice.append(",4") }
      return returnPrice
    }
  }
}
