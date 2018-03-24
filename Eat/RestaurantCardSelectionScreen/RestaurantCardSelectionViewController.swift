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
  @IBOutlet weak var eaterProgressHeaderView: UIView!
  @IBOutlet weak var eaterProgressBar: UIProgressView!
  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var nextEaterLabel: UILabel!
  @IBOutlet weak var restartButton: UIButton!
  @IBOutlet weak var keepButton: UIButton!
  @IBOutlet weak var kolodaView: KolodaView!
  @IBOutlet weak var eaterCountLabel: UILabel!
  @IBOutlet weak var eaterIcon: UIImageView!
  @IBOutlet weak var buttonsView: UIView!

  static func viewController(searchQuery: SearchQuery) -> RestaurantCardSelectionViewController {
    let storyboard = UIStoryboard(name: "RestaurantCardSelectionStoryboard", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantCardSelectionViewController") as? RestaurantCardSelectionViewController
      else { fatalError() }
    vc.searchQuery = searchQuery
    return vc
  }

  var searchQuery: SearchQuery!
  let dataManager = DataManager.default
  var restaurants : [Restaurant] = [] {
    didSet {
      kolodaView.reloadData()
    }
  }
  var keptRestaurantCount: [Int] = []
  var numberOfPlayers = 0
  var currNumOfPlayer = 1 {
    didSet {
      let progress = Float(currNumOfPlayer) / Float(numberOfPlayers)
      eaterProgressBar.setProgress(progress, animated: true)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    kolodaView.dataSource = self
    kolodaView.delegate = self

    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)

    dataManager.fetchRestaurants(with: searchQuery)
      .onSuccess { res in
        self.restaurants = res
        self.keptRestaurantCount = [Int](repeating: 0, count: self.restaurants.count)
      }.onFailure { error in
        // TODO: Error handling
        print(error)
    }

    restartButton.isUserInteractionEnabled = false
    restartButton.isHidden = true
    nextEaterLabel.text = "Finding Restaurants..."
    nextEaterLabel.isUserInteractionEnabled = false

    eaterIcon.isHidden = true
    numberOfPlayers = searchQuery.numberOfPeople
    let progress = Float(currNumOfPlayer) / Float(numberOfPlayers)
    eaterProgressBar.setProgress(progress, animated: true)
    setStyling()
  }

  @IBAction func closeButtonPressed(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  @IBAction func restartButtonPressed(_ sender: Any) {
    kolodaView.isHidden = false
    kolodaView.resetCurrentCardIndex()
    skipButton.isUserInteractionEnabled = true
    keepButton.isUserInteractionEnabled = true
    restartButton.isEnabled = false
    currNumOfPlayer = currNumOfPlayer + 1
    eaterCountLabel.text = String(currNumOfPlayer) + "/" + String(numberOfPlayers) + " eaters"
  }

  @IBAction func skipButtonTapped(_ sender: Any) {
    kolodaView.swipe(.left)
  }


  @IBAction func keepButtonTapped(_ sender: Any) {
    kolodaView.swipe(.right)
  }



  private func setStyling() {
    eaterCountLabel.text = String(currNumOfPlayer) + "/" + String(numberOfPlayers) + " eaters"
    nextEaterLabel.font = Font.body(size: 20)
    nextEaterLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)

    eaterCountLabel.font = Font.body(size: 18)
    eaterCountLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    restartButton.layer.cornerRadius = 10
    restartButton.backgroundColor = #colorLiteral(red: 0.362785995, green: 0.4117482901, blue: 0.9952250123, alpha: 1)
    restartButton.titleLabel?.font =  Font.button(size: 16)
  }
}

extension RestaurantCardSelectionViewController: KolodaViewDelegate {
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    kolodaView.isHidden = true
    skipButton.isUserInteractionEnabled = false
    keepButton.isUserInteractionEnabled = false
    eaterIcon.isHidden = false
    //nextEaterLabel.isHidden = false
    if currNumOfPlayer < numberOfPlayers {
      restartButton.isUserInteractionEnabled = true
      restartButton.isHidden = false
      restartButton.isEnabled = true
      nextEaterLabel.text = "Thanks for your input! Pass the phone to the next person"
    } else {
      nextEaterLabel.text = "Finding a place to eat..."
      restartButton.isHidden = true
      buttonsView.isHidden = true
      print("Go to next screen")
      // Added code to go to the next screen
      let viewController:UIViewController = UIStoryboard(name: "ChosenRestaurant", bundle: nil).instantiateViewController(withIdentifier: "ChosenRestaurantVC") as UIViewController
      self.present(viewController, animated: false, completion: nil)
    }
    print("No more card left")
  }

  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    let restaurantInfoVC = RestaurantInfoViewController.viewController(restaurant: restaurants[index])
    navigationController?.pushViewController(restaurantInfoVC, animated: true)
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
    return .default
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

