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
  let radius: Int // Radius of search
  let limit: Int // Number of restaurants to return
  let price: String // Matches one of "$", "$$" or "$$$"
  let vegetarian: Bool // Whether or not vegetarian options are needed
}
