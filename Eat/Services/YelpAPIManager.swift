//
//  YelpAPIManager.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import BrightFutures
import Alamofire

internal final class YelpAPIManager {
  
}

// MARK: Search
extension YelpAPIManager {
  // TODO: return Promise of JSON
  func search(keywords: String) -> Void {

    // Parse the keywords to use in the search query
    // let keywordsArray = [""]

    // Declare the Yelp Secret and APIKey
    let APIKey = "MM5X4kgi8SV3dsavDE8a-Tr_vyN7yWkZa4sYZIKUrzc0448Km9ri2No424GV8PfvAPMQU3hrYoxAuJev9gsDKNlabI3CRp5V-5qP3tlI8mdNWwst86TcsYc80pOIWnYx"
    let urlString = "https://api.yelp.com/v3/businesses/search?location=Canada"

    DispatchQueue.global().asyncValue {
      self.getRestaurantList(params: keywords, url: urlString, APIKey: APIKey)
      }.onSuccess { num in
        print(num)
    }
  }

  func getRestaurantList(params: String, url: String, APIKey: String) -> String {
    let headers = [
      "Authorization": "Bearer MM5X4kgi8SV3dsavDE8a-Tr_vyN7yWkZa4sYZIKUrzc0448Km9ri2No424GV8PfvAPMQU3hrYoxAuJev9gsDKNlabI3CRp5V-5qP3tlI8mdNWwst86TcsYc80pOIWnYx",
    ]
    Alamofire.request(url,headers: headers).responseJSON { response in

      if let json = response.result.value {
        print("JSON: \(json)")
      }
    }
    return "Cheese"
  }
}
