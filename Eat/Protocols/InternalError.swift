//
//  InternalError.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-23.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

protocol InternalError: Error {

}

enum GameError: InternalError {
  case noRestaurants
}

enum NetworkingError: InternalError {
  case invalidURL, requestFailed, timedOut
}
