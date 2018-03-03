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
}
