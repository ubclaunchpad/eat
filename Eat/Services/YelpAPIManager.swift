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
    guard let url = createURLString(query: query) else {
      print("Problem with URL")
      return Future(error: ReadmeError.RequestFailed)
    }
    print("Getting Restaurant List")

    return Future { complete in
      Alamofire.request(url, headers: headers).responseJSON { response in
        if let json = response.result.value {
          complete(.success(json))
        }
      }
    }
  }

  func createURLString(query: SearchQuery) -> URL? {
    // Declare the additonal filters for the query
    let eatingTimeQuery: URLQueryItem
    switch query.eatingTime {
    case .now:
      eatingTimeQuery = URLQueryItem(name: "open_now", value: "true")
      break
    case .later(let date):
      eatingTimeQuery = URLQueryItem(name: "open_at", value: String(Int(date.timeIntervalSince1970)))
      break
    }

    let queryItems = [URLQueryItem(name: "latitude", value: String(query.latitude)),
                      URLQueryItem(name: "longitude", value: String(query.longitude)),
                      URLQueryItem(name: "radius", value: String(query.radius)),
                      URLQueryItem(name: "price", value: query.priceString),
                      URLQueryItem(name: "limit", value: String(query.numberOfRestaurants)),
                      eatingTimeQuery]

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

  // Given the JSON from the Yelp API call, parse the data into a list of restaurant objects
  func generateRestaurantsList(json: Any) -> [Restaurant] {
    guard let dictionary = json as? [String: Any] else { return [] }
    let businesses = dictionary["businesses"] as! NSArray

    return businesses.flatMap { business in
      guard let businessDict = business as? [String: Any],
        let restaurantName = businessDict["name"] as? String,
        let restaurantRating = businessDict["rating"] as? Float,
        let restaurantPhone = businessDict["phone"] as? String,
        let restaurantStatus = businessDict["is_closed"] as? Bool,
        let imageUrl = businessDict["image_url"] as? String,
        let distance = businessDict["distance"] as? Double,
        let location = businessDict["location"] as? [String: Any],
        let address1 = location["address1"] as? String,
        let address2 = location["address2"] as? String,
        let address3 = location["address3"] as? String,
        let city = location["city"] as? String,
        let categories = businessDict["categories"] as? NSArray,
        let firstCategory = categories[0] as? [String: Any],
        let type = firstCategory["title"] as? String,
        let reviewCount = businessDict["review_count"] as? Int
        else { return nil }

      var address = address1
      if !address2.isEmpty {
        address = address + " " + address2
      }
      if !address3.isEmpty {
        address = address + " " + address3
      }
      address = address + ", " + city

      return Restaurant(name: restaurantName,
                        rating: restaurantRating,
                        phone: restaurantPhone,
                        status: restaurantStatus,
                        imageUrl: imageUrl,
                        address: address,
                        foodType: type,
                        reviewCount: reviewCount,
                        distance: distance)
    }
  }
}

