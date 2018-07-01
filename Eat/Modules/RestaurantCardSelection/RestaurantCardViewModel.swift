//
//  RestaurantCardViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-23.
//  Copyright © 2018 launchpad. All rights reserved.

import UIKit

protocol RestaurantCardViewModel {
  var restaurantName: String { get }
  var restaurantType: String { get }
  var distance: String { get }
  var numberOfReviews: String { get }
  var restaurantOpen: String { get }
  var restaurantOpenTextColor: UIColor { get }
  var restaurantImageURL: URL? { get }
  var restaurantRating: Int { get }
}

final class RestaurantCardViewModelImpl {

  fileprivate let restaurant: Restaurant

  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }
}

extension RestaurantCardViewModelImpl: RestaurantCardViewModel {
  var restaurantName: String {
    return restaurant.name
  }

  var restaurantType: String {
    return restaurant.foodType
  }

  var distance: String {
    return String(format: "%.2fkm".localize(), restaurant.distance/1000)
  }

  var numberOfReviews: String {
    return String(format: "%d Reviews".localize(), restaurant.reviewCount)
  }

  var restaurantOpen: String {
    return restaurant.status ? "Closed".localize() : "Open Now".localize()
  }

  var restaurantOpenTextColor: UIColor {
    return restaurant.status ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.1512300968, green: 0.6803299785, blue: 0.3782986999, alpha: 1)
  }

  var restaurantImageURL: URL? {
    return restaurant.imageURL
  }

  var restaurantRating: Int {
    return Int(round(restaurant.rating))
  }
}
