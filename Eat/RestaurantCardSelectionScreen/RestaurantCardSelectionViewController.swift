//
//  RestaurantCardSelectionViewController.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import Koloda

class RestaurantCardSelectionViewController: UIViewController {
  var restaurants : [Restaurant] {
    let res1 = Restaurant(name: "Res 1", rating: 0, phone: "", status: true)
    let res2 = Restaurant(name: "Res 2", rating: 0, phone: "", status: true)
    let res3 = Restaurant(name: "Res 3", rating: 0, phone: "", status: true)
    return [res1, res2, res3]
  }

  var keptRestaurantCount: [Int] = []
  var numberOfPlayers = 3


  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var nextPlayerLabel: UILabel!
  @IBOutlet weak var restartButton: UIButton!
  @IBOutlet weak var keepButton: UIButton!
  @IBOutlet weak var kolodaView: KolodaView!

  @IBAction func restartButtonPressed(_ sender: Any) {
    kolodaView.resetCurrentCardIndex()
    skipButton.isEnabled = true
    keepButton.isEnabled = true
    numberOfPlayers = numberOfPlayers - 1
    print("number of players:" + String(numberOfPlayers))
  }

  @IBAction func skipButtonTapped(_ sender: Any) {
    kolodaView.swipe(.left)
  }


  @IBAction func keepButtonTapped(_ sender: Any) {
    //keptRestaurantCount[kolodaView.currentCardIndex] = keptRestaurantCount[kolodaView.currentCardIndex] + 1
    kolodaView.swipe(.right)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    //TODO: call to yelp
//    var query = SearchQuery(latitude: 0.0, longitude: 0.0, radius: 500, limit: 0, price: 0, isVegetarian: false)
//    let yelpApiManager = YelpAPIManager()
//    restaurants = yelpApiManager.search(query: query)
    
    keptRestaurantCount = [Int](repeating: 0, count: restaurants.count)
    restartButton.isUserInteractionEnabled = false
    restartButton.isHidden = true
    nextPlayerLabel.isHidden = true
    nextPlayerLabel.isUserInteractionEnabled = false

    kolodaView.dataSource = self
    kolodaView.delegate = self

  }
}

extension RestaurantCardSelectionViewController: KolodaViewDelegate {
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    if numberOfPlayers > 0 {
      skipButton.isEnabled = false
      keepButton.isEnabled = false
      restartButton.isUserInteractionEnabled = true
      nextPlayerLabel.isHidden = false
      restartButton.isHidden = false
    } else {
      nextPlayerLabel.isHidden = true
      restartButton.isHidden = true
      print("Go to next screen")
    }
    print("No more card left")
  }

  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    //TODO: jump to yelp page of restaurant?
    UIApplication.shared.open(URL(string: "https://yelp.ca/")!, completionHandler: nil)
    print("card selected")
  }

  func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
    if direction == SwipeResultDirection.left {
      keptRestaurantCount[index] = keptRestaurantCount[index] - 1
      print(keptRestaurantCount)
    } else {
      keptRestaurantCount[index] = keptRestaurantCount[index] + 1
      print(keptRestaurantCount)
    }
  }
}

extension RestaurantCardSelectionViewController: KolodaViewDataSource {

  func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
    return restaurants.count
  }

  //TODO: return UIView instead of image
  // https://stackoverflow.com/questions/32111556/using-yalantis-koloda-library-to-load-more-than-just-1-uiview

  func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    return .fast
  }

  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    let viewModel = restaurants[index]
    let card = RestaurantCard()
    card.viewModel = viewModel
//    let card = UIImageView(image: UIImage(named: "Card_\(index+1)"))
    return card
  }

  func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
    return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
  }
}

