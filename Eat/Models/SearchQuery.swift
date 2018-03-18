//
//  SearchQuery.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

enum EatingTime {
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

struct SearchQuery {
  // Map
  var latitude: Float = 51.5033640 // Latitude of the restaurant
  var longitude: Float = -0.1276250 // Longitude of the restaurant.
  var radius: Int = 500 // Radius of search. Ssearch area is in METERS

  // People Count
  var numberOfPeople = 1

  // Eating Time
  var eatingTime: EatingTime = .now

  // Rating and Price
  var minimumRating: Double = 0
  var price: [Int] = [] // Matches one of "$", "$$" or "$$$" ($ = 1, $$ = 2, $$$ = 3)

  // Dietary Restrictions
  var dietary: DietaryRestrictions = .none
  var searchTerm: String? = nil
}

extension SearchQuery {
  var numberOfRestaurants: Int {
    switch numberOfPeople {
    case 1, 2, 3: return 5
    case 4:       return 8
    case 5, 7:    return 10
    case 6:       return 9
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
      if price.contains(3) { returnPrice.append("4") }
      return returnPrice
    }
  }
}
