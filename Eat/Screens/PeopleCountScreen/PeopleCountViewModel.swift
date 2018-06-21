//
//  PeopleCountViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-20.
//  Copyright © 2018 launchpad. All rights reserved.
//

protocol PeopleCountViewModel {
  var numberOfPeople: Int { get set }

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
  private let searchQuery: SearchQuery

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
      self.onNumberOfPeopleChange?(true, numberOfPeople)
    }
  }

  func decreasePeople() {
    if numberOfPeople > 1 {
      numberOfPeople -= 1
      onNumberOfPeopleChange?(true, numberOfPeople)
    }
  }

  func didTapNext() {
    searchQuery.numberOfPeople = numberOfPeople
    onNextButtonTapped?(searchQuery)
  }
}
