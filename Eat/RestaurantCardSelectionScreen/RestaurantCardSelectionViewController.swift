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
  @IBOutlet weak var eaterProgressBar: UIView!
  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var nextEaterLabel: UILabel!
  @IBOutlet weak var restartButton: UIButton!
  @IBOutlet weak var keepButton: UIButton!
  @IBOutlet weak var kolodaView: KolodaView!
  @IBOutlet weak var eaterCountLabel: UILabel!

  static func viewController(searchQuery: SearchQuery) -> RestaurantCardSelectionViewController {
    let storyboard = UIStoryboard(name: "RestaurantCardSelectionStoryboard", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantCardSelectionViewController") as? RestaurantCardSelectionViewController
      else { fatalError() }
    vc.searchQuery = searchQuery
    return vc
  }

  var searchQuery: SearchQuery!

  var restaurants : [Restaurant] = [] {
    didSet {
      kolodaView.reloadData()
    }
  }
  var keptRestaurantCount: [Int] = []
  var numberOfPlayers = 3
  var currNumOfPlayer = 1
  let dataManager = DataManager.default

  @IBAction func restartButtonPressed(_ sender: Any) {
    kolodaView.isHidden = false
    kolodaView.resetCurrentCardIndex()
    skipButton.isEnabled = true
    keepButton.isEnabled = true
    numberOfPlayers = numberOfPlayers - 1
    currNumOfPlayer = currNumOfPlayer + 1
    eaterCountLabel.text = String(currNumOfPlayer) + "/" + String(numberOfPlayers+currNumOfPlayer-1) + " eaters"
  }

  @IBAction func skipButtonTapped(_ sender: Any) {
    kolodaView.swipe(.left)
  }


  @IBAction func keepButtonTapped(_ sender: Any) {
    kolodaView.swipe(.right)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    kolodaView.dataSource = self
    kolodaView.delegate = self

    dataManager.fetchRestaurants(with: searchQuery)
      .onSuccess { res in
        self.restaurants = res
        self.keptRestaurantCount = [Int](repeating: 0, count: self.restaurants.count)
      }.onFailure { error in
        // TODO: Error handling
        print(error)
    }
    eaterCountLabel.text = String(currNumOfPlayer) + "/" + String(numberOfPlayers+currNumOfPlayer-1) + " eaters"
    restartButton.isUserInteractionEnabled = false
    restartButton.isHidden = true
    nextEaterLabel.isHidden = true
    nextEaterLabel.isUserInteractionEnabled = false
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
  }
}

extension RestaurantCardSelectionViewController: KolodaViewDelegate {
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    kolodaView.isHidden = true
    if currNumOfPlayer <= numberOfPlayers {
      skipButton.isEnabled = false
      keepButton.isEnabled = false
      restartButton.isUserInteractionEnabled = true
      nextEaterLabel.isHidden = false
      restartButton.isHidden = false
    } else {
      nextEaterLabel.isHidden = true
      restartButton.isHidden = true
      print("Go to next screen")
    }
    print("No more card left")
  }

  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    //TODO: directs to RestaurantInfoView
    if let url = URL(string: "https://yelp.ca/") {
      UIApplication.shared.open(url, completionHandler: nil)
    }
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

  func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    return .fast
  }

  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    let viewModel = restaurants[index]
    let card = RestaurantCard(restaurant: viewModel)
    card.viewModel = viewModel
    return card
  }

  func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
    return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
  }
}

