//
//  GameState.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-31.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

internal final class GameStateManager {
  let restaurants: [Restaurant]
  let numberOfPlayer: Int
  var restaurantScore: [Int]
  var currentPlayer: Int
  var currRestaurant: Int
  var perUserRestaurantCount: Int {
    switch numberOfPlayer {
    case 1, 2, 3:   return 4
    default:        return 3
    }
  }

  init(restaurants: [Restaurant], peopleNum: Int, currentPlayer: Int, currRestaurant: Int) {
    self.restaurants = restaurants
    self.numberOfPlayer = peopleNum
    self.currRestaurant = currRestaurant
    self.currentPlayer = currentPlayer
    self.restaurantScore = [Int](repeating: 0, count: self.restaurants.count)
  }

  func updateScore(index: Int, score: Int){
    let resIndex = (index + currRestaurant) % restaurants.count
    restaurantScore[resIndex] = restaurantScore[resIndex] + score
  }

  // update state for next player
  // return true if current player is not the last player & state can be updated
  // else return false
  func updateStateForNextPlayer() -> Bool {
    if currentPlayer < numberOfPlayer {
      currentPlayer = currentPlayer + 1
      currRestaurant = currRestaurant + perUserRestaurantCount
      return true
    } else {
      return false
    }
  }

  func getSubsetOfRestaurants() -> [Restaurant]{
    var subset: [Restaurant] = []
    for i in 0..<perUserRestaurantCount {
      let index = (currRestaurant+i) % restaurants.count
      subset.append(restaurants[index])
    }
    return subset
  }
}
