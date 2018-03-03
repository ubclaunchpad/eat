//
//  SearchQuery.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

struct SearchQuery {
  let latitude: Float // Latitude of the restaurant
  let longitude: Float // Longitude of the restaurant.
  let radius: Int // Radius of search. Ssearch area is in METERS
  let limit: Int // Number of restaurants to return
  let price: Int // Matches one of "$", "$$" or "$$$" ($ = 1, $$ = 2, $$$ = 3)
  let vegetarian: Bool // Whether or not vegetarian options are needed
}
