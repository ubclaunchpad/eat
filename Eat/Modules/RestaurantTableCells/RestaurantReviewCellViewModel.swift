//
//  RestaurantReviewCellViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

protocol RestaurantReviewCellViewModel {
  var userName: String { get }
  var content: String { get }
  var userImageURL: URL? { get }
  var rating: Int { get }
}

final class RestaurantReviewCellViewModelImpl {
  fileprivate let review: Review

  init(review: Review) {
    self.review = review
  }
}

extension RestaurantReviewCellViewModelImpl: RestaurantReviewCellViewModel {
  var userName: String {
    return review.userName
  }

  var content: String {
    return review.content
  }

  var userImageURL: URL? {
    return review.userImageURL
  }

  var rating: Int {
    return Int(round(review.userRating))
  }
}
