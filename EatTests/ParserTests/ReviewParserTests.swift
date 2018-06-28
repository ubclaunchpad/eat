//
//  ReviewParserTests.swift
//  EatTests
//
//  Created by Milton Leung on 2018-06-27.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest
@testable import Eat

class ReviewParserTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  private func jsonFrom(string: String) -> JSON {
    let data = removeControlChars(string: string).data(using: .utf8)!
    return try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSON
  }

  private func removeControlChars(string: String) -> String {
    let controlChar = CharacterSet.controlCharacters
    var range = string.rangeOfCharacter(from: controlChar)
    var mutableString = string
    while let removeRange = range {
      mutableString.removeSubrange(removeRange)
      range = mutableString.rangeOfCharacter(from: controlChar)
    }
    return mutableString
  }

  func testValidRestaurantJSON() {
    let parser = ReviewsParser()
    let reviews = parser.parse(from: jsonFrom(string: ReviewParserTests.validJSON))!

    XCTAssertEqual(reviews.count, 3)

    let firstReview = reviews[0]
    XCTAssertEqual(firstReview.userName, "Angelina T.")
    XCTAssertEqual(firstReview.userRating, 5)
    XCTAssertEqual(firstReview.userImageURL, URL(string: "https://s3-media1.fl.yelpcdn.com/photo/_ed0I3raSlyFeejuzG-uQw/o.jpg")!)
    XCTAssertEqual(firstReview.content, "The drinks are great, tastes like stuff you can't make at home. They make their own foam. Great presentation on drinks and the food.Servers are friendly...")
    XCTAssertEqual(firstReview.timeStamp, "2018-06-24 19:05:51")
  }

  func testInvalidRestaurantJSON() {
    let parser = ReviewsParser()
    let reviews = parser.parse(from: jsonFrom(string: ReviewParserTests.invalidJSON))!

    XCTAssertEqual(reviews.count, 0)
  }
}


extension ReviewParserTests {
  static let validJSON = """
{"reviews": [{"id": "EczCUd2rkM2micBKd5zRKA", "url": "https://www.yelp.com/biz/miku-vancouver-2?hrid=EczCUd2rkM2micBKd5zRKA&adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "text": "The drinks are great, tastes like stuff you can't make at home. They make their own foam. Great presentation on drinks and the food.\nServers are friendly...", "rating": 5, "time_created": "2018-06-24 19:05:51", "user": {"image_url": "https://s3-media1.fl.yelpcdn.com/photo/_ed0I3raSlyFeejuzG-uQw/o.jpg", "name": "Angelina T."}}, {"id": "LZxdmATPr7ZOHEgRfoY_UA", "url": "https://www.yelp.com/biz/miku-vancouver-2?hrid=LZxdmATPr7ZOHEgRfoY_UA&adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "text": "FANTASTIC food. I've been waiting for the right occasion to splurge a bit and I finally took the dive. Some of the best food I've ever eaten, without a...", "rating": 4, "time_created": "2018-06-19 20:53:14", "user": {"image_url": "https://s3-media4.fl.yelpcdn.com/photo/666OYTDOZ7RWLpTPhH4fYg/o.jpg", "name": "Jay P."}}, {"id": "Hm-MHbp7WhVSSDUJbR2NGw", "url": "https://www.yelp.com/biz/miku-vancouver-2?hrid=Hm-MHbp7WhVSSDUJbR2NGw&adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "text": "Oh I would dream and talk about that Aburi Oshi Sushi for a long time!\nIt was our first time visiting this place , we got ebi fritters for starter and all...", "rating": 5, "time_created": "2018-06-15 10:37:45", "user": {"image_url": "https://s3-media1.fl.yelpcdn.com/photo/3ynPRjiNWbgzYovsCdEqEQ/o.jpg", "name": "Garima C."}}], "total": 1193, "possible_languages": ["fr", "en", "zh", "pt", "sv", "da", "ja", "es"]}
"""
  static let invalidJSON = """
{"reviews": [{"id": "EczCUd2rkM2micBKd5zRKA", "url": "https://www.yelp.com/biz/miku-vancouver-2?hrid=EczCUd2rkM2micBKd5zRKA&adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "text1": "The drinks are great, tastes like stuff you can't make at home. They make their own foam. Great presentation on drinks and the food.\nServers are friendly...", "rating": 5, "time_created": "2018-06-24 19:05:51", "user": {"image_url": "https://s3-media1.fl.yelpcdn.com/photo/_ed0I3raSlyFeejuzG-uQw/o.jpg", "name": "Angelina T."}}, {"id": "LZxdmATPr7ZOHEgRfoY_UA", "url": "https://www.yelp.com/biz/miku-vancouver-2?hrid=LZxdmATPr7ZOHEgRfoY_UA&adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "text": "FANTASTIC food. I've been waiting for the right occasion to splurge a bit and I finally took the dive. Some of the best food I've ever eaten, without a...", "rating": 4, "time_created": "2018-06-19 20:53:14", "user": {"image_url": "https://s3-media4.fl.yelpcdn.com/photo/666OYTDOZ7RWLpTPhH4fYg/o.jpg"}}, {"id": "Hm-MHbp7WhVSSDUJbR2NGw", "url": "https://www.yelp.com/biz/miku-vancouver-2?hrid=Hm-MHbp7WhVSSDUJbR2NGw&adjust_creative=iY3I4WEHdQ6VfATiu2hMpg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=iY3I4WEHdQ6VfATiu2hMpg", "text": "Oh I would dream and talk about that Aburi Oshi Sushi for a long time!\nIt was our first time visiting this place , we got ebi fritters for starter and all...", "rating": 5, "user": {"image_url": "https://s3-media1.fl.yelpcdn.com/photo/3ynPRjiNWbgzYovsCdEqEQ/o.jpg", "name": "Garima C."}}], "total": 1193, "possible_languages": ["fr", "en", "zh", "pt", "sv", "da", "ja", "es"]}
"""
}
