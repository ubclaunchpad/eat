//
//  YelpAPIManager.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

internal enum Environment {
  case staging, production
}

internal final class YelpAPIManager {
  #if DEBUG
  static let environment: Environment = .staging
  #else
  static let environment: Environment = .staging
  #endif
}

// MARK: Search
extension YelpAPIManager {
  func search(searchQuery: SearchQuery) -> Promise<JSON> {
    return Promise { seal in
      Alamofire.request(YelpAPIRouter.restaurants(searchQuery: searchQuery))
        .responseJSON { response in
          if let json = response.result.value as? JSON {
            print(json)
            seal.fulfill(json)
          }
      }
    }
  }

  func getReviews(restaurantID: String) -> Promise<JSON> {
    return Promise { seal in
      Alamofire.request(YelpAPIRouter.reviews(restaurantID: restaurantID))
        .responseJSON { response in
          if let json = response.result.value as? JSON {
            seal.fulfill(json)
          }
      }
    }
  }
}
