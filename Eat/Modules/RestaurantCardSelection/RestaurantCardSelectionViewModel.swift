//
//  RestaurantCardSelectionViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-22.
//  Copyright © 2018 launchpad. All rights reserved.
//

protocol RestaurantCardSelectionViewModel {
  var eaterSearchingText: String { get }
  var eaterEndTurnText: String { get }
  var eaterCalculatingText: String { get }

  var progressTitle: String { get }
  var progressPercentage: Float { get }
  var numberOfRestaurants: Int { get }

  func itemViewModel(at index: Int) -> RestaurantCardViewModel
  func fetchRestaurants()
  func nextTurn()
  func cardSwiped(cardIndex: Int, direction: Direction)
  func outOfCards()
  func selectItem(at index: Int)
  func findGameResult()

  var onNoRestaurantsError: ((GameError) -> Void)? { get set }
  var onRestaurantTapped: ((Restaurant) -> Void)? { get set }
  var onFinalRestaurantSelected: ((Restaurant) -> Void)? { get set }
  var onCloseButtonTapped: (() -> Void)? { get set }

  var onRestaurantsUpdated: (() -> Void)? { get set }
  var onTurnStart: (() -> Void)? { get set }
  var onGameActive: (() -> Void)? { get set }
  var onTurnEnd: (() -> Void)? { get set }
  var onGameEnd: (() -> Void)? { get set }
}

final class RestaurantCardSelectionViewModelImpl {
  fileprivate struct Constants {
    static let minimumRestaurants = 2
  }

  let eaterSearchingText = "Finding Restaurants...".localize()
  let eaterEndTurnText = "Thanks for your input! Pass the phone to the next person".localize()
  let eaterCalculatingText = "Finding a place for us to eat...".localize()

  fileprivate let searchQuery: SearchQuery
  fileprivate let numberOfPlayers: Int
  fileprivate let dataManager: RestaurantDataManager

  fileprivate var currentPlayer = 1 {
    didSet {
      onTurnStart?()
    }
  }
  fileprivate var restaurants: [Restaurant] = [] {
    didSet {
      onRestaurantsUpdated?()
    }
  }
  fileprivate var gameStateManager: GameStateManager?


  init(searchQuery: SearchQuery, dataManager: RestaurantDataManager = DataManager.default) {
    self.searchQuery = searchQuery
    self.numberOfPlayers = searchQuery.numberOfPeople
    self.dataManager = dataManager
  }

  var onNoRestaurantsError: ((GameError) -> Void)?
  var onRestaurantTapped: ((Restaurant) -> Void)?
  var onFinalRestaurantSelected: ((Restaurant) -> Void)?
  var onCloseButtonTapped: (() -> Void)?

  var onRestaurantsUpdated: (() -> Void)?
  var onTurnStart: (() -> Void)?
  var onGameActive: (() -> Void)?
  var onTurnEnd: (() -> Void)?
  var onGameEnd: (() -> Void)?

  func startGame(restaurants: [Restaurant]) {
    self.gameStateManager = GameStateManager(restaurants: restaurants, peopleNum: self.numberOfPlayers)
    updateFromGameState()
    onGameActive?()
  }

  private func updateFromGameState() {
    guard let gameStateManager = self.gameStateManager else { return }
    self.restaurants = gameStateManager.getSubsetOfRestaurants()
    self.currentPlayer = gameStateManager.currentPlayer
  }
}

extension RestaurantCardSelectionViewModelImpl: RestaurantCardSelectionViewModel {
  var progressTitle: String {
    return "\(currentPlayer)/\(numberOfPlayers) eaters".localize()
  }

  var progressPercentage: Float {
    return Float(currentPlayer)/Float(numberOfPlayers)
  }

  var numberOfRestaurants: Int {
    return restaurants.count
  }

  func itemViewModel(at index: Int) -> RestaurantCardViewModel {
    let viewModel = RestaurantCardViewModelImpl(restaurant: restaurants[index])
    return viewModel
  }

  func fetchRestaurants() {
    dataManager.fetchRestaurants(with: searchQuery)
      .done { [weak self] restaurants in
        guard restaurants.count >= 2 else {
          self?.onNoRestaurantsError?(GameError.noRestaurants)
          return
        }
        self?.startGame(restaurants: restaurants)
      }.catch { error in
        // TODO: Error Handling
        print(error)
    }
  }

  func nextTurn() {
    currentPlayer += 1
    updateFromGameState()
  }

  func cardSwiped(cardIndex: Int, direction: Direction) {
    guard let gameStateManager = self.gameStateManager else { return }
    gameStateManager.updateScore(index: cardIndex, direction: direction)
  }

  func outOfCards() {
    guard let gameStateManager = self.gameStateManager else { return }
    if gameStateManager.isGameOver() {
      onGameEnd?()
    } else {
      gameStateManager.updateStateForNextPlayer()
      onTurnEnd?()
    }
  }

  func selectItem(at index: Int) {
    onRestaurantTapped?(restaurants[index])
  }

  func findGameResult() {
    guard let gameStateManager = self.gameStateManager else { return }
    let topRestaurant = gameStateManager.getTopRestaurant()
    onFinalRestaurantSelected?(topRestaurant)
  }
}
