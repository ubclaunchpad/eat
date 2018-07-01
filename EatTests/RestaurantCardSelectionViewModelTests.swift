//
//  RestaurantCardSelectionViewModelTests.swift
//  EatTests
//
//  Created by Milton Leung on 2018-06-28.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest
@testable import Eat
import PromiseKit

class RestaurantCardSelectionViewModelTests: XCTestCase {

  var viewModel: RestaurantCardSelectionViewModel!

  override func setUp() {
    super.setUp()
    viewModel = RestaurantCardSelectionViewModelImpl(searchQuery: searchQueryStub, dataManager: MockRestaurantDataManager())
  }

  override func tearDown() {
    super.tearDown()
    viewModel = nil
  }

  var searchQueryStub: SearchQuery {
    let searchQuery = SearchQuery()
    searchQuery.numberOfPeople = 2
    searchQuery.latitude = 49.2827
    searchQuery.longitude = -123.1207
    searchQuery.radius = 890
    searchQuery.mealTime = .now
    searchQuery.price = [1, 2, 3]
    searchQuery.dietary = .vegan
    searchQuery.searchTerm = "French"

    return searchQuery
  }

  func testFetchRestaurants() {
    viewModel.fetchRestaurants()

    let expectation = self.expectation(description: "fetch restaurants")

    viewModel.onGameActive = {
      expectation.fulfill()
    }

    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(viewModel.progressTitle, "1/2 eaters")
    XCTAssertEqual(viewModel.progressPercentage, Float(1)/Float(2))
    XCTAssertEqual(viewModel.numberOfRestaurants, 4)

    let restaurant1ViewModel = viewModel.itemViewModel(at: 0)
    XCTAssertEqual(restaurant1ViewModel.restaurantName, "Miku")

    let restaurant2ViewModel = viewModel.itemViewModel(at: 1)
    XCTAssertEqual(restaurant2ViewModel.restaurantName, "McDonalds")

    let restaurant3ViewModel = viewModel.itemViewModel(at: 2)
    XCTAssertEqual(restaurant3ViewModel.restaurantName, "Burger King")

    let restaurant4ViewModel = viewModel.itemViewModel(at: 3)
    XCTAssertEqual(restaurant4ViewModel.restaurantName, "Wendy's")
  }

  func testFetchRestaurantsFailed() {
    let dataManager = MockRestaurantDataManager()
    dataManager.fetchRestaurantsShouldPass = false
    viewModel = RestaurantCardSelectionViewModelImpl(searchQuery: searchQueryStub, dataManager: dataManager)

    viewModel.onNoRestaurantsError = { error in
      XCTAssertEqual(error, GameError.noRestaurants)
    }

    viewModel.fetchRestaurants()
  }
  
  func testGame() {
    viewModel.fetchRestaurants()

    let expectation = self.expectation(description: "fetch restaurants")

    viewModel.onGameActive = {
      expectation.fulfill()
    }

    waitForExpectations(timeout: 3, handler: nil)

    viewModel.cardSwiped(cardIndex: 0, direction: .right)
    viewModel.cardSwiped(cardIndex: 1, direction: .left)
    viewModel.cardSwiped(cardIndex: 2, direction: .right)
    viewModel.cardSwiped(cardIndex: 3, direction: .left)
    viewModel.outOfCards()

    viewModel.nextTurn()

    XCTAssertEqual(viewModel.progressTitle, "2/2 eaters")
    XCTAssertEqual(viewModel.progressPercentage, Float(2)/Float(2))
    XCTAssertEqual(viewModel.numberOfRestaurants, 4)


    viewModel.cardSwiped(cardIndex: 0, direction: .left)
    viewModel.cardSwiped(cardIndex: 1, direction: .left)
    viewModel.cardSwiped(cardIndex: 2, direction: .right)
    viewModel.cardSwiped(cardIndex: 3, direction: .left)
    viewModel.outOfCards()

    viewModel.onFinalRestaurantSelected = { restaurant in
      XCTAssertEqual(restaurant.name, "Burger King")
    }

    viewModel.findGameResult()
  }

  func testSelectRestaurants() {
    viewModel.fetchRestaurants()

    let expectation = self.expectation(description: "fetch restaurants")

    viewModel.onGameActive = {
      expectation.fulfill()
    }

    waitForExpectations(timeout: 3, handler: nil)

    viewModel.onRestaurantTapped = { restaurant in
      XCTAssertEqual(restaurant.name, "Miku")
    }

    viewModel.selectItem(at: 0)
  }
}

class MockRestaurantDataManager: RestaurantDataManager {
  var fetchRestaurantsShouldPass = true

  func fetchRestaurants(with query: SearchQuery) -> Promise<[Restaurant]> {
    return Promise { seal in
      if fetchRestaurantsShouldPass {
        seal.fulfill([restaurant1, restaurant2, restaurant3, restaurant4])
      } else {
        seal.reject(NetworkingError.requestFailed)
      }
    }
  }

  func fetchReviews(with restaurantID: String) -> Promise<[Review]> {
    return Promise { seal in

    }
  }
}

extension MockRestaurantDataManager {
  var restaurant1: Restaurant {
    return Restaurant(name: "Miku",
                      rating: 4.5,
                      phone: "604 - 111 - 1212",
                      status: true,
                      imageURL: URL(string: "http://www.yelp.com/")!,
                      address: "123 Main St. Vancouver, BC",
                      foodType: "Japanese",
                      reviewCount: 5,
                      distance: 2000,
                      id: "123",
                      yelpURL: URL(string: "http://www.yelp.com/")!,
                      lat: 10.5,
                      lon: 12.6)
  }

  var restaurant2: Restaurant {
    return Restaurant(name: "McDonalds",
                      rating: 3.5,
                      phone: "604 - 111 - 1213",
                      status: true,
                      imageURL: URL(string: "http://www.yelp.com/")!,
                      address: "124 Main St. Vancouver, BC",
                      foodType: "Fast Food",
                      reviewCount: 52,
                      distance: 2001,
                      id: "124",
                      yelpURL: URL(string: "http://www.yelp.com/")!,
                      lat: 10.2,
                      lon: 12.9)
  }

  var restaurant3: Restaurant {
    return Restaurant(name: "Burger King",
                      rating: 2.5,
                      phone: "604 - 111 - 1214",
                      status: true,
                      imageURL: URL(string: "http://www.yelp.com/")!,
                      address: "125 Main St. Vancouver, BC",
                      foodType: "Burgers",
                      reviewCount: 51,
                      distance: 2002,
                      id: "125",
                      yelpURL: URL(string: "http://www.yelp.com/")!,
                      lat: 10.3,
                      lon: 12.8)
  }

  var restaurant4: Restaurant {
    return Restaurant(name: "Wendy's",
                      rating: 1.5,
                      phone: "604 - 111 - 1215",
                      status: false,
                      imageURL: URL(string: "http://www.yelp.com/")!,
                      address: "126 Main St. Vancouver, BC",
                      foodType: "American",
                      reviewCount: 50,
                      distance: 2003,
                      id: "126",
                      yelpURL: URL(string: "http://www.yelp.com/")!,
                      lat: 10.4,
                      lon: 12.7)
  }

}
