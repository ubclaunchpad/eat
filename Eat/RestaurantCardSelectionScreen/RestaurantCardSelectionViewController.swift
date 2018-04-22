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
  var gameStateManager: GameStateManager?
  var restaurants : [Restaurant] = [] {
    didSet {
      kolodaView.reloadData()
    }
  }
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
    numberOfPlayers = searchQuery.numberOfPeople
    setStyling()

    dataManager.fetchRestaurants(with: searchQuery)
      .onSuccess { res in
        if res.count < 2 {
          let noRestaurantFoundVC = NoRestaurantFoundViewController.viewController()
          self.present(noRestaurantFoundVC, animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
          }
        }

        self.gameStateManager = GameStateManager(restaurants: res, peopleNum: self.numberOfPlayers, currentPlayer: 1, currRestaurant: 0)
        guard let gameStateManager = self.gameStateManager else {
          return
        }
        self.currNumOfPlayer = gameStateManager.currentPlayer
        self.restaurants = gameStateManager.getSubsetOfRestaurants()
        let progress = Float(self.currNumOfPlayer) / Float(self.numberOfPlayers)
        self.eaterProgressBar.setProgress(progress, animated: true)
        self.enableSelectionButtons()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
          self.nextEaterLabel.alpha = 0
        }, completion: { _ in
          self.nextEaterLabel.isHidden = true
        })
      }.onFailure { error in
        // TODO: Error handling
        print(error)
    }
  }

  @IBAction func closeButtonPressed(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }

  @IBAction func restartButtonPressed(_ sender: Any) {
    kolodaView.isHidden = false
    hideNextPlayerViewElements()
    enableSelectionButtons()

    kolodaView.resetCurrentCardIndex()
    currNumOfPlayer = currNumOfPlayer + 1
    updateEaterCountLabel()

    guard let gameStateManager = self.gameStateManager else {
      return
    }
    self.restaurants = gameStateManager.getSubsetOfRestaurants()
    self.currNumOfPlayer = gameStateManager.currentPlayer
  }

  @IBAction func skipButtonTapped(_ sender: Any) {
    kolodaView.swipe(.left)
  }


  @IBAction func keepButtonTapped(_ sender: Any) {
    kolodaView.swipe(.right)
  }

  private func setStyling() {
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    kolodaView.layer.cornerRadius = 15

    nextEaterLabel.font = Font.body(size: 20)
    nextEaterLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    nextEaterLabel.text = "Finding Restaurants..."
    nextEaterLabel.isUserInteractionEnabled = false

    updateEaterCountLabel()
    eaterCountLabel.font = Font.body(size: 18)
    eaterCountLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    eaterIcon.isHidden = true

    restartButton.layer.cornerRadius = 10
    restartButton.backgroundColor = #colorLiteral(red: 0.362785995, green: 0.4117482901, blue: 0.9952250123, alpha: 1)
    restartButton.titleLabel?.font =  Font.button(size: 16)
    restartButton.isHidden = true
    restartButton.layer.shadowColor = #colorLiteral(red: 0.2009466769, green: 0.2274558959, blue: 0.5609335343, alpha: 1)
    restartButton.layer.shadowOffset = CGSize(width: 0, height: 10)
    restartButton.layer.masksToBounds = false
    restartButton.layer.shadowRadius = 5.0
    restartButton.layer.shadowOpacity = 0.25

    skipButton.isEnabled = false
    keepButton.isEnabled = false
    skipButton.setImage(#imageLiteral(resourceName: "grey_button_skip"), for: .disabled)
    keepButton.setImage(#imageLiteral(resourceName: "grey_button_keep"), for: .disabled)
    skipButton.setImage(#imageLiteral(resourceName: "button_skip"), for: .normal)
    keepButton.setImage(#imageLiteral(resourceName: "button_keep"), for: .normal)
  }

  private func updateEaterCountLabel(){
    eaterCountLabel.text = String(currNumOfPlayer) + "/" + String(numberOfPlayers) + " eaters"
  }

  private func hideNextPlayerViewElements(){
    restartButton.isEnabled = false
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.nextEaterLabel.alpha = 0
      self.restartButton.alpha = 0
      self.eaterIcon.alpha = 0
    }, completion: { _ in
      self.nextEaterLabel.isHidden = true
      self.restartButton.isHidden = true
      self.eaterIcon.isHidden = true
    })
  }

  private func setOutOfCardStyling() {
    skipButton.isEnabled = false
    keepButton.isEnabled = false
    self.kolodaView.isHidden = true
  }

  private func setNextPlayerStyling() {
    nextEaterLabel.text = "Thanks for your input! Pass the phone to the next person"
    restartButton.isEnabled = true
    self.eaterIcon.isHidden = false
    self.nextEaterLabel.isHidden = false
    self.restartButton.isHidden = false
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
      self.eaterIcon.alpha = 1
      self.nextEaterLabel.alpha = 1
      self.restartButton.alpha = 1
    }, completion: nil)
  }

  private func setFindingRestaurantStyling() {
    nextEaterLabel.text = "Finding a place for us to eat..."
    self.eaterIcon.isHidden = false
    self.nextEaterLabel.isHidden = false
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
      self.eaterIcon.alpha = 1
      self.nextEaterLabel.alpha = 1
      self.buttonsView.alpha = 0
    }, completion: { _ in
      self.buttonsView.isHidden = true
    })
  }

  private func enableSelectionButtons(){
    skipButton.isEnabled = true
    keepButton.isEnabled = true
  }
}

extension RestaurantCardSelectionViewController: KolodaViewDelegate {

  @objc func pushChosenRestaurantVC(index: Int) {
    guard let gameStateManager = self.gameStateManager,
      let topRestaurant = gameStateManager.getTopRestaurant() else {
      return
    }

    let viewController = ChosenRestaurantViewController.viewController(restaurant: topRestaurant)
    self.navigationController?.pushViewController(viewController, animated: true)
  }

  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    self.setOutOfCardStyling()
    guard let gameStateManager = self.gameStateManager else {
      return
    }
    if (gameStateManager.updateStateForNextPlayer()) {
      self.setNextPlayerStyling()
    } else {
      self.setFindingRestaurantStyling()
      Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.pushChosenRestaurantVC(index:)), userInfo: nil, repeats: false)
    }
  }

  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    let restaurantInfoVC = RestaurantInfoViewController.viewController(restaurant: self.restaurants[index])
    self.navigationController?.pushViewController(restaurantInfoVC, animated: true)
  }

  func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
    guard let gameState = gameStateManager else {
      return
    }
    if direction == SwipeResultDirection.left {
      gameState.updateScore(index: index, score: -1)
      print(gameState.restaurantScore)
    } else {
      gameState.updateScore(index: index, score: 1)
      print(gameState.restaurantScore)
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

