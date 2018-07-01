//
//  YelpAPITests.swift
//  EatTests
//
//  Created by Milton Leung on 2018-06-27.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest
@testable import Eat

class YelpAPITests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  var searchQuery1: SearchQuery {
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

  var searchQuery2: SearchQuery {
    let searchQuery = SearchQuery()
    searchQuery.numberOfPeople = 3
    searchQuery.latitude = 49.2827
    searchQuery.longitude = -123.1207
    searchQuery.radius = 890
    searchQuery.mealTime = .now
    searchQuery.price = [1, 2]
    searchQuery.dietary = .halal
    searchQuery.searchTerm = "French"

    return searchQuery
  }

  func testYelpURL1() {
    let urlRequest = YelpAPIRouter.restaurants(searchQuery: searchQuery1)
    let url = "https://api.yelp.com/v3/businesses/search?latitude=49.2827&longitude=-123.1207&radius=890&price=1,2,3,4&limit=4&open_now=true&categories=vegan&term=French"
    XCTAssertEqual(urlRequest.fullURL.absoluteString, url)
  }

  func testYelpURL2() {
    let urlRequest = YelpAPIRouter.restaurants(searchQuery: searchQuery2)
    let url = "https://api.yelp.com/v3/businesses/search?latitude=49.2827&longitude=-123.1207&radius=890&price=1,2&limit=6&open_now=true&categories=halal&term=French"
    XCTAssertEqual(urlRequest.fullURL.absoluteString, url)
  }
}
