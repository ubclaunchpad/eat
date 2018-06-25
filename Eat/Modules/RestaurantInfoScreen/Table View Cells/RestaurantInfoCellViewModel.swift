//
//  RestaurantInfoCellViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

protocol RestaurantTitleCellViewModel {
  var restaurantName: String { get }
  var restaurantType: String { get }
  var distance: String { get }
  var numberOfReviews: String { get }
  var restaurantOpen: String { get }
  var restaurantOpenTextColor: UIColor { get }
  var restaurantRating: Int { get }
}

protocol RestaurantInfoMenuCellViewModel {
  var exploreYelpText: String { get }
}

protocol RestaurantInfoAddressCellViewModel {
  var restaurantAddress: String { get }
}

protocol RestaurantPhotoCellViewModel {
  var restaurantImageURL: URL? { get }
}

final class RestaurantInfoCellViewModelImpl {
  let exploreYelpText = "Explore on Yelp".localize()

  fileprivate let restaurant: Restaurant

  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }
}

extension RestaurantInfoCellViewModelImpl: RestaurantInfoMenuCellViewModel {}

extension RestaurantInfoCellViewModelImpl: RestaurantTitleCellViewModel {
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

  var restaurantRating: Int {
    return Int(round(restaurant.rating))
  }
}

extension RestaurantInfoCellViewModelImpl: RestaurantInfoAddressCellViewModel {
  var restaurantAddress: String {
    return restaurant.address
  }
}

extension RestaurantInfoCellViewModelImpl: RestaurantPhotoCellViewModel {
  var restaurantImageURL: URL? {
    return restaurant.imageURL
  }
}
