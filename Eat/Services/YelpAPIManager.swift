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

internal final class YelpAPIManager {
  let headers = [
    "Authorization": "Bearer \(APIKeys.yelp)"
  ]
}

// MARK: Search
extension YelpAPIManager {
  func search(query: SearchQuery) -> Promise<JSON> {
    return Promise { seal in
      guard let url = createURLString(query: query) else {
        seal.reject(NetworkingError.invalidURL)
        return
      }

      Alamofire.request(url, headers: headers).responseJSON { response in
        if let json = response.result.value as? JSON {
          seal.fulfill(json)
        }
      }
    }
  }

  func createURLString(query: SearchQuery) -> URL? {
    var queryItems = [
      URLQueryItem(name: "latitude", value: String(query.latitude)),
      URLQueryItem(name: "longitude", value: String(query.longitude)),
      URLQueryItem(name: "radius", value: String(query.radius)),
      URLQueryItem(name: "price", value: query.priceString),
      URLQueryItem(name: "limit", value: String(query.numberOfRestaurants))
    ]

    // Declare the additonal filters for the query
    switch query.mealTime {
    case .now:
      queryItems.append(URLQueryItem(name: "open_now", value: "true"))
      break
    case .later(let date):
      queryItems.append(URLQueryItem(name: "open_at", value: String(Int(date.timeIntervalSince1970))))
      break
    }

    switch query.dietary {
    case .vegan:
      queryItems.append(URLQueryItem(name: "categories", value: "vegan"))
    case .vegetarian:
      queryItems.append(URLQueryItem(name: "categories", value: "vegetarian"))
    case .halal:
      queryItems.append(URLQueryItem(name: "categories", value: "halal"))
    case .none:
      break
    }

    if !query.searchTerm.isEmpty {
      queryItems.append(URLQueryItem(name: "search", value: query.searchTerm))
    }

    // Base URL
    guard var urlComps = URLComponents(string: "https://api.yelp.com/v3/businesses/search") else { return nil }

    // Adds the additional paramaters onto the query string
    urlComps.queryItems =  queryItems

    // Gets the URL string from the object
    guard let resultURL = urlComps.url else {
      print("Failed to create URL")
      return nil
    }
    print(resultURL)

    return resultURL
  }


  func getReviews(restaurantID: String) -> Promise<JSON> {
    return Promise { seal in
      let urlString = "https://api.yelp.com/v3/businesses/\(restaurantID)/reviews"

      guard let url = URL(string: urlString) else {
        seal.reject(NetworkingError.invalidURL)
        return
      }

      Alamofire.request(url, headers: headers).responseJSON { response in
        if let json = response.result.value as? JSON {
          seal.fulfill(json)
        }
      }
    }
  }
}
