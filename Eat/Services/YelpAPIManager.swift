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

  enum ReadmeError: Error {
    case RequestFailed, TimeServiceError
  }

  // INPUT: Search Query Object
  // RETURN: Promise<JSON>
  // INFO: Returns a Promise<JSON> which contains the list of restaurants matching the query
  func search(query: SearchQuery) -> Void {

    // Launch async call to get restaurants
    DispatchQueue.global().asyncValue {
      self.getRestaurantList(query: query)
      }.onSuccess { result in
        result.andThen { result in
          switch result {
          case .success(let val):
            print(val)
          case .failure(_):
            print("No Restaurants returned")
          }
        }
    }
  }

  func getRestaurantList(query: SearchQuery) -> Future<Any, ReadmeError> {
    // Declare the headers for the query
    let headers = [
      "Authorization": "Bearer MM5X4kgi8SV3dsavDE8a-Tr_vyN7yWkZa4sYZIKUrzc0448Km9ri2No424GV8PfvAPMQU3hrYoxAuJev9gsDKNlabI3CRp5V-5qP3tlI8mdNWwst86TcsYc80pOIWnYx",
    ]
    // Get the customized URL string based on the query
    let url = createURLString(query: query)

    return Future { complete in
      DispatchQueue.global().asyncValue {
        Alamofire.request(url, headers: headers)
        }.onSuccess { response in
          response.responseJSON { response in
            if let json = response.result.value {
                complete(.success(json))
            }
            }
          }
    }
  }

  func createURLString(query: SearchQuery) -> URL {
    let queryItems = [URLQueryItem(name: "location", value: "Canada")]
    var urlComps = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
    urlComps.queryItems =  queryItems
    let resultURL = urlComps.url

    return resultURL!
  }
}
