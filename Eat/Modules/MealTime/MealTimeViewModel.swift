//
//  MealTimeViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-21.
//  Copyright © 2018 launchpad. All rights reserved.
//

protocol MealTimeViewModel {
  var restaurantHoursHeader: String { get }
  var headerTitle: String { get }
  var restaurantOpen: String { get }
  var doneToolbarTitle: String { get }
  var nowToolbarTitle: String { get }
  var nextButtonTitle: String { get }
  var backButtonTitle: String { get }

  func setDefaults()
  func dateChanged(newTime: MealTime)
  func didTapNext()

  var onCloseButtonTapped: (() -> Void)? { get set }
  var onBackButtonTapped: (() -> Void)? { get set }
  var onNextButtonTapped: ((SearchQuery) -> Void)? { get set }

  var onSelectedDateChanged: ((String) -> Void)? { get set }
}

final class MealTimeViewModelImpl {
  let restaurantHoursHeader = "The restaurant should be open ".localize()
  let headerTitle = "When do you want to eat?".localize()
  let restaurantOpen = "now".localize()
  let doneToolbarTitle = "Done".localize()
  let nowToolbarTitle = "Now".localize()
  let nextButtonTitle = "Next".localize()
  let backButtonTitle = "Back".localize()

  fileprivate let searchQuery: SearchQuery

  fileprivate var mealTime: MealTime = .now {
    didSet {
      searchQuery.mealTime = mealTime
      switch mealTime {
      case .now:
        onSelectedDateChanged?("now")
      case .later(let date):
        if (date.sameDate(date: Date())) {
          onSelectedDateChanged?(date.toStringToday())
        } else {
          onSelectedDateChanged?(date.toString())
        }
      }
    }
  }

  init(searchQuery: SearchQuery) {
    self.searchQuery = searchQuery
  }

  var onCloseButtonTapped: (() -> Void)?
  var onBackButtonTapped: (() -> Void)?
  var onNextButtonTapped: ((SearchQuery) -> Void)?

  var onSelectedDateChanged: ((String) -> Void)?
}

extension MealTimeViewModelImpl: MealTimeViewModel {
  func didTapNext() {
    onNextButtonTapped?(searchQuery)
  }

  func setDefaults() {
    mealTime = searchQuery.mealTime
  }

  func dateChanged(newTime: MealTime) {
    mealTime = newTime
  }
}
