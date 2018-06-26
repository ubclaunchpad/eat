//
//  FoodPreferencesViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-22.
//  Copyright © 2018 launchpad. All rights reserved.
//

protocol FoodPreferencesViewModel {
  var veganButtonTitle: String { get }
  var vegetarianButtonTitle: String { get }
  var halalButtonTitle: String { get }
  var preferenceTextFieldPlaceholder: String { get }
  var finishButtonTitle: String { get }
  var backButtonTitle: String { get }

  func setDefaults()
  func dietaryChanged(dietary: DietaryRestriction)
  func preferenceChanged(preference: String)
  func didTapFinish()

  var onCloseButtonTapped: (() -> Void)? { get set }
  var onBackButtonTapped: (() -> Void)? { get set }
  var onFinishButtonTapped: ((SearchQuery) -> Void)? { get set }

  var onDietaryChanged: ((DietaryRestriction) -> Void)? { get set }
  var onPreferenceChanged: ((String) -> Void)? { get set }
  var onDefaultPreference: (() -> Void)? { get set }
}

final class FoodPreferencesViewModelImpl {
  let veganButtonTitle = "Vegan".localize()
  let vegetarianButtonTitle = "Vegetarian".localize()
  let halalButtonTitle = "Halal".localize()
  let preferenceTextFieldPlaceholder = "Eg: French, bubble tea".localize()
  let finishButtonTitle = "Finish".localize()
  let backButtonTitle = "Back".localize()

  fileprivate let searchQuery: SearchQuery

  init(searchQuery: SearchQuery) {
    self.searchQuery = searchQuery
  }

  var onCloseButtonTapped: (() -> Void)?
  var onBackButtonTapped: (() -> Void)?
  var onFinishButtonTapped: ((SearchQuery) -> Void)?

  var onDietaryChanged: ((DietaryRestriction) -> Void)?
  var onPreferenceChanged: ((String) -> Void)?
  var onDefaultPreference: (() -> Void)?
}

extension FoodPreferencesViewModelImpl: FoodPreferencesViewModel {
  func setDefaults() {
    onDietaryChanged?(searchQuery.dietary)
    if searchQuery.searchTerm.isEmpty {
      onDefaultPreference?()
    } else {
      onPreferenceChanged?(searchQuery.searchTerm)
    }
  }

  func dietaryChanged(dietary: DietaryRestriction) {
    if searchQuery.dietary == dietary {
      searchQuery.dietary = .none
    } else {
      searchQuery.dietary = dietary
    }
    onDietaryChanged?(searchQuery.dietary)
  }

  func preferenceChanged(preference: String) {
    searchQuery.searchTerm = preference
  }

  func didTapFinish() {
    onFinishButtonTapped?(searchQuery)
  }
}
