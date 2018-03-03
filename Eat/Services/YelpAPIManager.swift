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
  func search(query: SearchQuery) -> Future<[Restaurant], ReadmeError> {

    return Future { complete in
    // Launch async call to get restaurants
    let returnVal = getRestaurantList(query: query)

    returnVal.andThen { result in
        switch result {
        case .success(let val):
          let restaurants = self.generateRestaurantsList(json: val)
          complete(.success(restaurants))
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
    print("Getting Restaurant List")

    return Future { complete in
      Alamofire.request(url, headers: headers).responseJSON { response in
        if let json = response.result.value {
          complete(.success(json))
          }
      }
    }
  }

  func createURLString(query: SearchQuery) -> URL {
    // Declare the additonal filters for the query
    let queryItems = [URLQueryItem(name: "latitude", value: String(query.latitude)),
                      URLQueryItem(name: "longitude", value: String(query.longitude)),
                      URLQueryItem(name: "radius", value: String(query.radius)),
                      URLQueryItem(name: "price", value: String(query.price)),
                      URLQueryItem(name: "limit", value: String(query.limit))]

    // Base URL
    var urlComps = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!

    // Adds the additional paramaters onto the query string
    urlComps.queryItems =  queryItems

    // Gets the URL string from the object
    let resultURL = urlComps.url
    print(resultURL)

    return resultURL!
  }

  // Given the JSON from the Yelp API call, parse the data into a list of restaurant objects
  func generateRestaurantsList(json: Any) -> [Restaurant] {
    var restaurants: [Restaurant] = []

    if let dictionary = json as? [String: Any] {
      let businesses = dictionary["businesses"] as! NSArray
      for business in businesses {
        if let businessDict = business as? [String: Any] {
          let restaurantName = businessDict["name"] as! String
          let restaurantRating = businessDict["rating"] as! NSNumber
          let restaurantPhone = businessDict["phone"] as! String
          let restaurantStatus = businessDict["is_closed"] as! Bool

          let newResto = Restaurant(name: restaurantName, rating: restaurantRating, phone: restaurantPhone, status: restaurantStatus)
          restaurants.append(newResto)
        }
      }
    }
    return restaurants
  }
}

