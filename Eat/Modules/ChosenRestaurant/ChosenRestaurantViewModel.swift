//
//  ChosenRestaurantViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

protocol ChosenRestaurantViewModel {

  func photoViewModel(at indexPath: IndexPath) -> RestaurantPhotoCellViewModel
  func titleViewModel(at indexPath: IndexPath) -> RestaurantTitleCellViewModel
  func phoneViewModel(at indexPath: IndexPath) -> RestaurantPhoneCellViewModel
  func menuViewModel(at indexPath: IndexPath) -> RestaurantExploreMenuCellViewModel
  func mapViewModel(at indexPath: IndexPath) -> RestaurantMapCellViewModel
  func selectCall()
  func selectExploreMenu()
  func requestUserReview()

  var onExitButtonTapped: (() -> Void)? { get set }
}

final class ChosenRestaurantViewModelImpl {
  fileprivate let storeManager = StoreManager()

  fileprivate let restaurant: Restaurant

  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }

  var onExitButtonTapped: (() -> Void)?
  var onCallPhone: ((String) -> Void)?
  var onOpenSafari: ((URL) -> Void)?
}

extension ChosenRestaurantViewModelImpl: ChosenRestaurantViewModel {
  func photoViewModel(at indexPath: IndexPath) -> RestaurantPhotoCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func titleViewModel(at indexPath: IndexPath) -> RestaurantTitleCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func phoneViewModel(at indexPath: IndexPath) -> RestaurantPhoneCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func menuViewModel(at indexPath: IndexPath) -> RestaurantExploreMenuCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func mapViewModel(at indexPath: IndexPath) -> RestaurantMapCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func selectCall() {
    onCallPhone?(restaurant.phone)
  }

  func selectExploreMenu() {
    onOpenSafari?(restaurant.yelpURL)
  }

  func requestUserReview() {
    storeManager.requestUserReview()
  }
}
