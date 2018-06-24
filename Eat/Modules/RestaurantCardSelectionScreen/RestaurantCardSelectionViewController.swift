//
//  RestaurantCardSelectionViewController.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import Koloda

final class RestaurantCardSelectionViewController: UIViewController {
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

  fileprivate var viewModel: RestaurantCardSelectionViewModel

  init(viewModel: RestaurantCardSelectionViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    updateHeader()
    viewModel.fetchRestaurants()
  }

  func configure() {
    view.backgroundColor = Colors.backgroundColor

    kolodaView.layer.cornerRadius = 15
    kolodaView.delegate = self
    kolodaView.dataSource = self

    nextEaterLabel.font = Font.body(size: 20)
    nextEaterLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    nextEaterLabel.text = viewModel.eaterSearchingText
    nextEaterLabel.isUserInteractionEnabled = false

    eaterCountLabel.font = Font.body(size: 18)
    eaterCountLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    eaterProgressBar.setProgress(0, animated: false)

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

    viewModel.onRestaurantsUpdated = updateKolodaView
    viewModel.onTurnStart = updateHeader
    viewModel.onGameActive = setupActiveGameViews
    viewModel.onTurnEnd = setupEndTurnViews
    viewModel.onGameEnd = endGame
  }

  func updateKolodaView() {
    kolodaView.reloadData()
  }

  private func updateHeader() {
    eaterProgressBar.setProgress(viewModel.progressPercentage, animated: true)
    eaterCountLabel.text = viewModel.progressTitle
  }

  func setupActiveGameViews() {
    skipButton.isEnabled = true
    keepButton.isEnabled = true

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

  func setupNoCardsViews() {
    skipButton.isEnabled = false
    keepButton.isEnabled = false
    self.kolodaView.isHidden = true
  }

  private func setupEndTurnViews() {
    nextEaterLabel.text = viewModel.eaterEndTurnText
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

  private func setupFindingRestaurantViews() {
    nextEaterLabel.text = viewModel.eaterCalculatingText
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

  private func endGame() {
    setupFindingRestaurantViews()
    Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(onFindingTimerEnd), userInfo: nil, repeats: false)
  }
  
  @objc func onFindingTimerEnd() {
    viewModel.findGameResult()
  }
}

// MARK: IBActions
extension RestaurantCardSelectionViewController {
  @IBAction func skipButtonTapped() {
    kolodaView.swipe(.left)
  }

  @IBAction func startButtonPressed() {
    kolodaView.isHidden = false
    setupActiveGameViews()

    kolodaView.resetCurrentCardIndex()
    viewModel.nextTurn()
  }

  @IBAction func keepButtonTapped() {
    kolodaView.swipe(.right)
  }

  @IBAction func closeButtonTapped() {
    viewModel.onCloseButtonTapped?()
  }
}

extension RestaurantCardSelectionViewController: KolodaViewDataSource {
  func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
    return viewModel.numberOfRestaurants
  }

  func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    return .default
  }

  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    let card: RestaurantCard = RestaurantCard.instanceFromNib()
    card.configure(with: viewModel.itemViewModel(at: index))
    return card
  }

  func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
    return CustomOverlayView.instanceFromNib()
  }
}

extension RestaurantCardSelectionViewController: KolodaViewDelegate {
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    self.setupNoCardsViews()
    viewModel.outOfCards()
  }

  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    viewModel.selectItem(at: index)
  }

  func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
    switch direction {
    case .left:
      viewModel.cardSwiped(cardIndex: index, direction: .left)
    case .right:
      viewModel.cardSwiped(cardIndex: index, direction: .right)
    default:
      break
    }
  }
}
