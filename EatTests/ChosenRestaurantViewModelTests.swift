//
//  ChosenRestaurantViewModelTests.swift
//  EatTests
//
//  Created by Milton Leung on 2018-06-27.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest
@testable import Eat
import Contacts
import CoreLocation

class ChosenRestaurantViewModelTests: XCTestCase {

  var viewModel: ChosenRestaurantViewModelImpl!

  override func setUp() {
    super.setUp()
    viewModel = ChosenRestaurantViewModelImpl(restaurant: restaurant)
  }

  override func tearDown() {
    super.tearDown()
    viewModel = nil
  }

  var restaurant: Restaurant {
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

  func testCellViewModels() {
    let indexPath = IndexPath(row: 0, section: 0)

    let photoViewModel = viewModel.photoViewModel(at: indexPath)
    XCTAssertEqual(photoViewModel.restaurantImageURL, restaurant.imageURL)

    let titleViewModel = viewModel.titleViewModel(at: indexPath)
    XCTAssertEqual(titleViewModel.restaurantName, restaurant.name)
    XCTAssertEqual(titleViewModel.restaurantType, restaurant.foodType)
    XCTAssertEqual(titleViewModel.distance, "2.00km")
    XCTAssertEqual(titleViewModel.numberOfReviews, "5 Reviews")
    XCTAssertEqual(titleViewModel.restaurantOpen, "Closed")
    XCTAssertEqual(titleViewModel.restaurantOpenTextColor, #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(titleViewModel.restaurantRating, 5)

    let phoneViewModel = viewModel.phoneViewModel(at: indexPath)
    XCTAssertEqual(phoneViewModel.restaurantPhoneNumber, restaurant.phone)
  }

  func testCall() {
    viewModel.onCallPhone = { phone in
      XCTAssertEqual(phone, self.restaurant.phone)
    }
    viewModel.selectCall()
  }

  func testSafari() {
    viewModel.onOpenSafari = { url in
      XCTAssertEqual(url, self.restaurant.yelpURL)
    }
    viewModel.selectExploreMenu()
  }
}
