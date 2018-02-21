//
//  SearchQuery.swift
//  Eat
//
//  Created by Henry Jones on 2018-02-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

struct SearchQuery {
  let latitude: Float
  let longitude: Float
  let radius: Int
  let limit: Int
  let price: String
  let keywords: [String]
}
