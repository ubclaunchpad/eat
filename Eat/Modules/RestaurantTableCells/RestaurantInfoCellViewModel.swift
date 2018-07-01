//
//  RestaurantInfoCellViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import CoreLocation
import Contacts

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

protocol RestaurantPhoneCellViewModel {
  var callRestaurantText: String { get }
  var restaurantPhoneNumber: String { get }
}

protocol RestaurantExploreMenuCellViewModel {
  var exploreMenuText: String { get }
}

protocol RestaurantMapCellViewModel {
  var openMapsButtonTitle: String { get }
  var restaurantName: String { get }
  var addressDictionary: [String: Any] { get }
  var location: CLLocationCoordinate2D { get }
}

final class RestaurantCellViewModelImpl {
  let exploreYelpText = "Explore on Yelp".localize()
  let callRestaurantText = "Call restaurant".localize()
  let exploreMenuText = "Explore on Yelp".localize()
  let openMapsButtonTitle = "Open in Maps".localize()

  fileprivate let restaurant: Restaurant

  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }
}

extension RestaurantCellViewModelImpl: RestaurantInfoMenuCellViewModel {}
extension RestaurantCellViewModelImpl: RestaurantExploreMenuCellViewModel {}

extension RestaurantCellViewModelImpl: RestaurantTitleCellViewModel {
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

extension RestaurantCellViewModelImpl: RestaurantInfoAddressCellViewModel {
  var restaurantAddress: String {
    return restaurant.address
  }
}

extension RestaurantCellViewModelImpl: RestaurantPhotoCellViewModel {
  var restaurantImageURL: URL? {
    return restaurant.imageURL
  }
}

extension RestaurantCellViewModelImpl: RestaurantPhoneCellViewModel {
  var restaurantPhoneNumber: String {
    return restaurant.phone
  }
}

extension RestaurantCellViewModelImpl: RestaurantMapCellViewModel {
  var location: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: restaurant.lat, longitude: restaurant.lon)
  }

  var addressDictionary: [String: Any] {
    return [CNPostalAddressStreetKey: restaurantName]
  }
}

