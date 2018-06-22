//
//  PeopleCountViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-20.
//  Copyright © 2018 launchpad. All rights reserved.
//

protocol PeopleCountViewModel {
  var nextButtonTitle: String { get }
  var backButtonTitle: String { get }

  func setDefaults()
  func increasePeople()
  func decreasePeople()
  func didTapNext()

  var onCloseButtonTapped: (() -> Void)? { get set }
  var onBackButtonTapped: (() -> Void)? { get set }
  var onNextButtonTapped: ((SearchQuery) -> Void)? { get set }

  var onNumberOfPeopleChange: ((Bool, Int) -> Void)? { get set }
}

final class PeopleCountViewModelImpl {
  let nextButtonTitle = "Next".localize()
  let backButtonTitle = "Back".localize()
  
  fileprivate let searchQuery: SearchQuery

  var numberOfPeople: Int = 1

  /// Coordinator Handlers
  var onCloseButtonTapped: (() -> Void)?
  var onBackButtonTapped: (() -> Void)?
  var onNextButtonTapped: ((SearchQuery) -> Void)?

  // View Controller Handlers
  var onNumberOfPeopleChange: ((Bool, Int) -> Void)?

  init(searchQuery: SearchQuery) {
    self.searchQuery = searchQuery
  }
}

extension PeopleCountViewModelImpl: PeopleCountViewModel {
  func setDefaults() {
    numberOfPeople = searchQuery.numberOfPeople
    self.onNumberOfPeopleChange?(false, numberOfPeople)
  }
  
  func increasePeople() {
    if numberOfPeople < 10 {
      numberOfPeople += 1
      searchQuery.numberOfPeople = numberOfPeople
      self.onNumberOfPeopleChange?(true, numberOfPeople)
    }
  }

  func decreasePeople() {
    if numberOfPeople > 1 {
      numberOfPeople -= 1
      searchQuery.numberOfPeople = numberOfPeople
      onNumberOfPeopleChange?(true, numberOfPeople)
    }
  }

  func didTapNext() {
    onNextButtonTapped?(searchQuery)
  }
}
