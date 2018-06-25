//
//  ReviewsParser.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-24.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

struct ReviewParser {
  func parse(from json: JSON) -> Review? {
    guard
      let rating = json["rating"] as? Float,
      let content = json["text"] as? String,
      let time = json["time_created"] as? String,

      let user = json["user"] as? JSON,
      let userName = user["name"] as? String,
      let userImage = user["image_url"] as? String
      else {
        return nil
    }

    return Review(userName: userName,
                  userRating: rating,
                  userImage: userImage,
                  content: content,
                  timeStamp: time)
  }
}

struct ReviewsParser {
  func parse(from json: JSON) -> [Review]? {
    let reviewParser = ReviewParser()

    guard let businesses = json["reviews"] as? JSONArray else { return nil }

    return businesses.compactMap { reviewParser.parse(from: $0) }
  }
}
