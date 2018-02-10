//
//  DataManager.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

internal final class DataManager {
  static var `default` = DataManager()

  fileprivate let yelpAPIManager: YelpAPIManager
  init(yelpAPIManager: YelpAPIManager = YelpAPIManager()) {
    self.yelpAPIManager = yelpAPIManager
  }
}

// Yelp API
extension DataManager {
  func fetchRestaurants(with query: SearchQuery) -> [Restaurant] {
    // fetch json twice, once with vegan, other without

    // turn json into list of restaurants, see link

    return []
  }
}
