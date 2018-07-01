//
//  RatingPriceViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-21.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

enum PriceButton {
  case one, two, three
}

protocol RatingPriceViewModel {
  var ratingsTitle: String { get }
  var priceTitle: String { get }
  var nextButtonTitle: String { get }
  var backButtonTitle: String { get }

  func setDefaults()
  func ratingChanged(value: Double)
  func priceButtonTapped(button: PriceButton)
  func didTapNext()

  var onCloseButtonTapped: (() -> Void)? { get set }
  var onBackButtonTapped: (() -> Void)? { get set }
  var onNextButtonTapped: ((SearchQuery) -> Void)? { get set }

  var onRatingChanged: ((Float, String) -> Void)? { get set }
  var onPriceChanged: ((PriceButton, Bool) -> Void)? { get set }
}

final class RatingPriceViewModelImpl {
  let ratingsTitle = "How picky are you with Yelp ratings?".localize()
  let priceTitle = "Choose your price range:".localize()
  let nextButtonTitle = "Next".localize()
  let backButtonTitle = "Back".localize()

  fileprivate let searchQuery: SearchQuery

  fileprivate var ratingValue: Double = 3
  fileprivate var isOneSelected = false
  fileprivate var isTwoSelected = false
  fileprivate var isThreeSelected = false

  init(searchQuery: SearchQuery) {
    self.searchQuery = searchQuery
  }

  /// Coordinator Handlers
  var onCloseButtonTapped: (() -> Void)?
  var onBackButtonTapped: (() -> Void)?
  var onNextButtonTapped: ((SearchQuery) -> Void)?

  var onRatingChanged: ((Float, String) -> Void)?
  var onPriceChanged: ((PriceButton, Bool) -> Void)?

  fileprivate func transformPriceInput() -> [Int] {
    var prices: [Int] = []
    if isOneSelected { prices.append(1) }
    if isTwoSelected { prices.append(2) }
    if isThreeSelected { prices.append(3) }
    return prices
  }
}

extension RatingPriceViewModelImpl: RatingPriceViewModel {
  func setDefaults() {
    ratingChanged(value: searchQuery.minimumRating)
    searchQuery.price.forEach {
      switch $0 {
      case 1:
        isOneSelected = true
        onPriceChanged?(.one, true)
      case 2:
        isTwoSelected = true
        onPriceChanged?(.two, true)
      case 3:
        isThreeSelected = true
        onPriceChanged?(.three, true)
      default: break
      }
    }
  }

  func ratingChanged(value: Double) {
    ratingValue = value
    if ratingValue < 5 {
      onRatingChanged?(Float(ratingValue), "Minimum \(ratingValue)+".localize())
    } else {
      onRatingChanged?(Float(ratingValue), "Minimum \(ratingValue)".localize())
    }
    searchQuery.minimumRating = ratingValue
  }

  func priceButtonTapped(button: PriceButton) {
    switch button {
    case .one:
      isOneSelected = !isOneSelected
      onPriceChanged?(.one, isOneSelected)
    case .two:
      isTwoSelected = !isTwoSelected
      onPriceChanged?(.two, isTwoSelected)
    case .three:
      isThreeSelected = !isThreeSelected
      onPriceChanged?(.three, isThreeSelected)
    }
    searchQuery.price = transformPriceInput()
  }

  func didTapNext() {
    onNextButtonTapped?(searchQuery)
  }
}
