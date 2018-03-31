//
//  DataManager.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import BrightFutures
import Alamofire

internal final class DataManager {
  static var `default` = DataManager()

  //check first launch for onboarding tutorial

  fileprivate let yelpAPIManager: YelpAPIManager
  init(yelpAPIManager: YelpAPIManager = YelpAPIManager()) {
    self.yelpAPIManager = yelpAPIManager
  }
}

// Yelp API
extension DataManager {

  enum ReadmeError: Error {
    case RequestFailed, TimeServiceError
  }

  func fetchRestaurants(with query: SearchQuery) -> Future<[Restaurant], ReadmeError> {
    return Future { complete in
      let result = yelpAPIManager.search(query: query)
      result.andThen { result in
        switch result {
        case .success(let val):
          complete(.success(val))
        case .failure(_):
          // TODO: make this return an error
          print("No Restaurants returned")
        }
      }
    }
  }

  func fetchReviews(with resId: String) -> Future<[Review], ReadmeError> {
    return Future { complete in
      let result = yelpAPIManager.getReviews(resId: resId)
      result.andThen { result in
        switch result {
        case .success(let val):
          complete(.success(val))
        case .failure(_):
          print("No reviews returned")
        }
      }
    }
  }
}

// check first launch to show tutorial
extension DataManager {
  func isFirstLaunch() -> Bool {
    return !UserDefaults.standard.bool(forKey: "launchedBefore")
  }
  func setFirstLaunch(value: Bool) {
    UserDefaults.standard.set(value, forKey: "launchedBefore")
  }
}

