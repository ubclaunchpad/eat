//
//  RestaurantParser.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-24.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

struct RestaurantParser {
  func parse(from json: JSON) -> Restaurant? {
    guard
      let restaurantName = json["name"] as? String,
      let restaurantRating = json["rating"] as? Float,
      let restaurantPhone = json["display_phone"] as? String,
      let restaurantStatus = json["is_closed"] as? Bool,
      let id = json["id"] as? String,
      let yelpURLString = json["url"] as? String,
      let yelpURL = URL(string: yelpURLString),
      let imageURLString = json["image_url"] as? String,
      let distance = json["distance"] as? Double,
      let location = json["location"] as? JSON,
      let address1 = location["address1"] as? String,
      let city = location["city"] as? String,
      let categories = json["categories"] as? NSArray,
      let firstCategory = categories[0] as? JSON,
      let type = firstCategory["title"] as? String,
      let reviewCount = json["review_count"] as? Int,
      let coord = json["coordinates"] as? JSON,
      let lat = coord["latitude"] as? Double,
      let lon = coord["longitude"] as? Double
      else { return nil }

    let address2 = location["address2"] as? String ?? ""
    let address3 = location["address3"] as? String ?? ""
    let imageURL = URL(string: imageURLString)

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
                      imageURL: imageURL,
                      address: address,
                      foodType: type,
                      reviewCount: reviewCount,
                      distance: distance,
                      id: id,
                      yelpURL: yelpURL,
                      lat: lat,
                      lon: lon)
    
  }
}

struct RestaurantsParser {
  func parse(from json: JSON) -> [Restaurant]? {
    let restaurantParser = RestaurantParser()

    guard let businesses = json["businesses"] as? JSONArray else { return nil }

    return businesses.compactMap { restaurantParser.parse(from: $0) }
  }
}
