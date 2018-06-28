//
//  DataManager.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher
import PromiseKit

internal typealias JSON = [String: Any]
internal typealias JSONArray = [JSON]

protocol RestaurantDataManager {
  func fetchRestaurants(with query: SearchQuery) -> Promise<[Restaurant]>
  func fetchReviews(with restaurantID: String) -> Promise<[Review]>
}

protocol OnboardingDataManager {
  func isFirstLaunch() -> Bool
  func setFirstLaunch(value: Bool)
}

internal final class DataManager {
  static var `default` = DataManager()

  fileprivate let yelpAPIManager: YelpAPIManager
  
  init(yelpAPIManager: YelpAPIManager = YelpAPIManager()) {
    self.yelpAPIManager = yelpAPIManager
  }
}

// Yelp API
extension DataManager: RestaurantDataManager {
  func fetchRestaurants(with query: SearchQuery) -> Promise<[Restaurant]> {
    return yelpAPIManager.search(searchQuery: query)
      .compactMap { RestaurantsParser().parse(from: $0) }
  }

  func fetchReviews(with restaurantID: String) -> Promise<[Review]> {
    return yelpAPIManager.getReviews(restaurantID: restaurantID)
      .compactMap { ReviewsParser().parse(from: $0) }
  }
}

// check first launch to show tutorial
extension DataManager: OnboardingDataManager {
  func isFirstLaunch() -> Bool {
    return !UserDefaults.standard.bool(forKey: "launchedBefore")
  }
  
  func setFirstLaunch(value: Bool) {
    UserDefaults.standard.set(value, forKey: "launchedBefore")
  }
}

