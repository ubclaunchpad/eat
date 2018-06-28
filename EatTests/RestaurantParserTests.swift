//
//  RestaurantParserTests.swift
//  EatTests
//
//  Created by Milton Leung on 2018-06-27.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest
@testable import Eat

class RestaurantParserTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  private func jsonFrom(string: String) -> JSON {
    let data = string.data(using: .utf8)!
    return try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
  }

  func testValidRestaurantJSON() {
    let parser = RestaurantsParser()
    let restaurants = parser.parse(from: jsonFrom(string: RestaurantParserTests.validJSON))!

    XCTAssertEqual(restaurants.count, 4)

    let firstRestaurant = restaurants[0]
    XCTAssertEqual(firstRestaurant.id, "4EV_ZcQmjAmP3pmO-_nb2A")
    XCTAssertEqual(firstRestaurant.name, "Miku")
    XCTAssertEqual(firstRestaurant.rating, 4.5)
    XCTAssertEqual(firstRestaurant.phone, "+1 604-568-3900")
    XCTAssertEqual(firstRestaurant.status, false)
    XCTAssertEqual(firstRestaurant.imageURL, URL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/OBIHYzIe_0-RYJ8TjQ8CdQ/o.jpg")!)
    XCTAssertEqual(firstRestaurant.address, "200 Granville Street Suite 70, Vancouver")
    XCTAssertEqual(firstRestaurant.foodType, "Japanese")
    XCTAssertEqual(firstRestaurant.reviewCount, 1193)
    XCTAssertEqual(firstRestaurant.distance, 749.5958872370245)
    XCTAssertEqual(firstRestaurant.yelpURL, URL(string: "https://www.yelp.com/biz/miku-vancouver-2?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg")!)
    XCTAssertEqual(firstRestaurant.lat, 49.2870083463066)
    XCTAssertEqual(firstRestaurant.lon, -123.113051358108)
  }

  func testInvalidRestaurantJSON() {
    let parser = RestaurantsParser()
    let restaurants = parser.parse(from: jsonFrom(string: RestaurantParserTests.invalidJSON))!

    XCTAssertEqual(restaurants.count, 0)
  }
}


extension RestaurantParserTests {
  static let validJSON = """
{"businesses": [{"id": "4EV_ZcQmjAmP3pmO-_nb2A", "alias": "miku-vancouver-2", "name": "Miku", "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/OBIHYzIe_0-RYJ8TjQ8CdQ/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/miku-vancouver-2?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "review_count": 1193, "categories": [{"alias": "japanese", "title": "Japanese"}, {"alias": "sushi", "title": "Sushi Bars"}], "rating": 4.5, "coordinates": {"latitude": 49.2870083463066, "longitude": -123.113051358108}, "transactions": [], "price": "$$$", "location": {"address1": "200 Granville Street", "address2": "Suite 70", "address3": "", "city": "Vancouver", "zip_code": "V6C 1S4", "country": "CA", "state": "BC", "display_address": ["200 Granville Street", "Suite 70", "Vancouver, BC V6C 1S4", "Canada"]}, "phone": "+16045683900", "display_phone": "+1 604-568-3900", "distance": 749.5958872370245}, {"id": "_4R46MNkwx9MeOyt0YfNxA", "alias": "chambar-vancouver", "name": "Chambar", "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/7u8SwmSCB9VA7C_-_xpmQw/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/chambar-vancouver?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "review_count": 1133, "categories": [{"alias": "belgian", "title": "Belgian"}], "rating": 4.0, "coordinates": {"latitude": 49.2801460007961, "longitude": -123.109925328073}, "transactions": [], "price": "$$$", "location": {"address1": "568 Beatty Street", "address2": "", "address3": "", "city": "Vancouver", "zip_code": "V6B 2L3", "country": "CA", "state": "BC", "display_address": ["568 Beatty Street", "Vancouver, BC V6B 2L3", "Canada"]}, "phone": "+16048797119", "display_phone": "+1 604-879-7119", "distance": 852.0474023068181}, {"id": "0iEFOEQIvk7RFcOo_jkOGA", "alias": "japadog-vancouver-16", "name": "Japadog", "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/An4d8BalhCcolZ1yBmowHw/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/japadog-vancouver-16?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "review_count": 940, "categories": [{"alias": "hotdog", "title": "Hot Dogs"}, {"alias": "foodstands", "title": "Food Stands"}], "rating": 4.0, "coordinates": {"latitude": 49.2823501230721, "longitude": -123.12433719635}, "transactions": [], "price": "$", "location": {"address1": "899 Burrard Street", "address2": null, "address3": "", "city": "Vancouver", "zip_code": "V6Z 2K6", "country": "CA", "state": "BC", "display_address": ["899 Burrard Street", "Vancouver, BC V6Z 2K6", "Canada"]}, "phone": "", "display_phone": "", "distance": 245.1721535675139}, {"id": "gt1BSfVFvzI-qHdJ3LUZug", "alias": "blue-water-cafe-vancouver", "name": "Blue Water Cafe", "image_url": "https://s3-media3.fl.yelpcdn.com/bphoto/C-PwVUhZjOpGROt2IwUlpA/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/blue-water-cafe-vancouver?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "review_count": 743, "categories": [{"alias": "seafood", "title": "Seafood"}, {"alias": "raw_food", "title": "Live/Raw Food"}, {"alias": "bars", "title": "Bars"}], "rating": 4.5, "coordinates": {"latitude": 49.2761945, "longitude": -123.1209935}, "transactions": [], "price": "$$$$", "location": {"address1": "1095 Hamilton St", "address2": "", "address3": "", "city": "Vancouver", "zip_code": "V6B 5T4", "country": "CA", "state": "BC", "display_address": ["1095 Hamilton St", "Vancouver, BC V6B 5T4", "Canada"]}, "phone": "+16046888078", "display_phone": "+1 604-688-8078", "distance": 727.8302392471717}], "total": 1400, "region": {"center": {"longitude": -123.121, "latitude": 49.2827}}}
"""
  static let invalidJSON = """
{"businesses": [{"alias": "miku-vancouver-2", "name": "Miku", "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/OBIHYzIe_0-RYJ8TjQ8CdQ/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/miku-vancouver-2?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "review_count": 1193, "categories": [{"alias": "japanese", "title": "Japanese"}, {"alias": "sushi", "title": "Sushi Bars"}], "rating": 4.5, "coordinates": {"latitude": 49.2870083463066, "longitude": -123.113051358108}, "transactions": [], "price": "$$$", "location": {"address1": "200 Granville Street", "address2": "Suite 70", "address3": "", "city": "Vancouver", "zip_code": "V6C 1S4", "country": "CA", "state": "BC", "display_address": ["200 Granville Street", "Suite 70", "Vancouver, BC V6C 1S4", "Canada"]}, "phone": "+16045683900", "display_phone": "+1 604-568-3900", "distance": 749.5958872370245}, {"id": "_4R46MNkwx9MeOyt0YfNxA", "alias": "chambar-vancouver", "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/7u8SwmSCB9VA7C_-_xpmQw/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/chambar-vancouver?adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "review_count": 1133, "categories": [{"alias": "belgian", "title": "Belgian"}], "rating": 4.0, "coordinates": {"latitude": 49.2801460007961, "longitude": -123.109925328073}, "transactions": [], "price": "$$$", "location": {"address1": "568 Beatty Street", "address2": "", "address3": "", "city": "Vancouver", "zip_code": "V6B 2L3", "country": "CA", "state": "BC", "display_address": ["568 Beatty Street", "Vancouver, BC V6B 2L3", "Canada"]}, "phone": "+16048797119", "display_phone": "+1 604-879-7119", "distance": 852.0474023068181}], "total": 967, "region": {"center": {"longitude": -123.121, "latitude": 49.2827}}}
"""
}
