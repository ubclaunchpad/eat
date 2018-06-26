//
//  RestaurantInfoViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-24.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

protocol RestaurantInfoViewModel {
  var infoHeader: String { get }
  var reviewsHeader: String { get }
  var numberOfReviews: Int { get }

  func fetchReviews()
  func photoViewModel(at indexPath: IndexPath) -> RestaurantPhotoCellViewModel
  func titleViewModel(at indexPath: IndexPath) -> RestaurantTitleCellViewModel
  func infoMenuViewModel(at indexPath: IndexPath) -> RestaurantInfoMenuCellViewModel
  func infoAddressViewModel(at indexPath: IndexPath) -> RestaurantInfoAddressCellViewModel
  func reviewViewModel(at indexPath: IndexPath) -> RestaurantReviewCellViewModel
  func selectInfoMenu()

  var onReviewsUpdated: (() -> Void)? { get set }

  var onExitButtonTapped: (() -> Void)? { get set }
}

final class RestaurantInfoViewModelImpl {
  let infoHeader = "INFO".localize()
  let reviewsHeader = "REVIEWS".localize()

  fileprivate let restaurant: Restaurant

  fileprivate let dataManager = DataManager.default

  fileprivate var reviews: [Review] = [] {
    didSet {
      onReviewsUpdated?()
    }
  }

  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }

  var onReviewsUpdated: (() -> Void)?

  var onExitButtonTapped: (() -> Void)?
  var onOpenSafari: ((URL) -> Void)?
}

extension RestaurantInfoViewModelImpl: RestaurantInfoViewModel {
  var numberOfReviews: Int {
    return reviews.count
  }

  func fetchReviews() {
    dataManager.fetchReviews(with: restaurant.id)
      .done { [weak self] reviews in
        self?.reviews = reviews
      }.catch { error in
        print(error)
    }
  }

  func photoViewModel(at indexPath: IndexPath) -> RestaurantPhotoCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func titleViewModel(at indexPath: IndexPath) -> RestaurantTitleCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func infoMenuViewModel(at indexPath: IndexPath) -> RestaurantInfoMenuCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func infoAddressViewModel(at indexPath: IndexPath) -> RestaurantInfoAddressCellViewModel {
    return RestaurantCellViewModelImpl(restaurant: restaurant)
  }

  func reviewViewModel(at indexPath: IndexPath) -> RestaurantReviewCellViewModel {
    return RestaurantReviewCellViewModelImpl(review: reviews[indexPath.row])
  }

  func selectInfoMenu() {
    onOpenSafari?(restaurant.yelpURL)
  }
}
