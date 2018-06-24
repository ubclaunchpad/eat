//
//  GameState.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-31.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

enum Direction {
  case left, right

  var points: Int {
    switch self {
    case .left: return -1
    case .right: return 1
    }
  }
}

internal final class GameStateManager {
  let restaurants: [Restaurant]
  let numberOfPlayer: Int
  var restaurantScore: [Int]
  var currentPlayer: Int = 1
  var currRestaurant: Int = 0
  var perUserRestaurantCount: Int {
    switch numberOfPlayer {
    case 1, 2, 3:   return min(4, restaurants.count)
    default:        return min(3, restaurants.count)
    }
  }

  init?(restaurants: [Restaurant], peopleNum: Int) {
    guard restaurants.count >= 2 else { return nil }
    self.restaurants = restaurants
    self.numberOfPlayer = peopleNum
    self.restaurantScore = [Int](repeating: 0, count: self.restaurants.count)
  }

  func updateScore(index: Int, direction: Direction){
    let resIndex = (index + currRestaurant) % restaurants.count
    restaurantScore[resIndex] = restaurantScore[resIndex] + direction.points
  }

  // update state for next player
  // return true if current player is not the last player & state can be updated
  // else return false
  func updateStateForNextPlayer() {
    currentPlayer = currentPlayer + 1
    currRestaurant = currRestaurant + perUserRestaurantCount
  }

  func isGameOver() -> Bool {
    return currentPlayer == numberOfPlayer
  }

  func getSubsetOfRestaurants() -> [Restaurant] {
    var subset: [Restaurant] = []
    for i in 0..<perUserRestaurantCount {
      let index = (currRestaurant+i) % restaurants.count
      subset.append(restaurants[index])
    }
    return subset
  }

  func getTopRestaurant() -> Restaurant {
    var topScore: Int = -(self.numberOfPlayer)
    var topScoringRestaurants: [Restaurant] = []

    for index in 0..<restaurantScore.count {
      if (restaurantScore[index] > topScore) {
        topScore = restaurantScore[index]
        topScoringRestaurants = [restaurants[index]]
      } else if (restaurantScore[index] == topScore) {
        topScoringRestaurants.append(restaurants[index])
      }
    }

    let ranNum = randomNumber(min: 0, max: topScoringRestaurants.count)
    print(topScoringRestaurants)
    print(ranNum)
    return topScoringRestaurants[ranNum]
  }

  func randomNumber(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max-min)) + UInt32(min))
  }
}
