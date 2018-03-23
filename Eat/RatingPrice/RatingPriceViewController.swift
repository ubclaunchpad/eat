//
//  RatingPriceViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-03-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RatingPriceViewController: UIViewController {
  private struct Constants {
    static let sliderInterval: Double = 0.5
  }

  @IBOutlet weak var ratingQuestionLabel: UILabel!
  @IBOutlet weak var minimumRatingLabel: UILabel!
  @IBOutlet weak var ratingSlider: UISlider!
  @IBOutlet weak var priceLabel: UILabel!

  @IBOutlet weak var onePriceButton: UIButton!
  @IBOutlet weak var twoPriceButton: UIButton!
  @IBOutlet weak var threePriceButton: UIButton!

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!

  static func viewController(searchQuery: SearchQuery) -> RatingPriceViewController {
    let storyboard = UIStoryboard(name: "RatingPrice", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "RatingPriceViewController") as? RatingPriceViewController
      else { fatalError() }
    vc.searchQuery = searchQuery
    return vc
  }

  var searchQuery: SearchQuery!

  var isOneSelected = false
  var isTwoSelected = false
  var isThreeSelected = false

  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyling()
    setNavigation()
    setSlider()

    ratingQuestionLabel.text = "How picky are you with Yelp ratings?"
    priceLabel.text = "Choose your price range:"
  }

  func applyStyling() {
    ratingQuestionLabel.font = Font.header(size: 13)
    ratingQuestionLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    minimumRatingLabel.font = Font.header(size: 24)
    minimumRatingLabel.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)
    priceLabel.font = Font.header(size: 13)
    priceLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)

    onePriceButton.layer.cornerRadius = 8
    onePriceButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    onePriceButton.titleLabel?.font =  Font.boldButton(size: 18)
    unselectButton(button: onePriceButton)

    twoPriceButton.layer.cornerRadius = 8
    twoPriceButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    twoPriceButton.titleLabel?.font =  Font.boldButton(size: 18)
    unselectButton(button: twoPriceButton)

    threePriceButton.layer.cornerRadius = 8
    threePriceButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    threePriceButton.titleLabel?.font =  Font.boldButton(size: 18)
    unselectButton(button: threePriceButton)
  }

  func unselectButton(button: UIButton) {
    button.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    button.layer.borderWidth = 2
    button.backgroundColor = UIColor.white
  }

  func selectButton(button: UIButton) {
    button.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: button.frame, andColors: [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)])
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.borderWidth = 0
  }

  func setSlider() {
    ratingSlider.setThumbImage(#imageLiteral(resourceName: "Slider"), for: .normal)
    ratingSlider.minimumTrackTintColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    ratingSlider.maximumTrackTintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.8, alpha: 1)
    ratingSlider.maximumValue = 5
    ratingSlider.minimumValue = 0

    ratingSlider.value = 3
    ratingSliderChanged()
  }

  @IBAction func ratingSliderChanged() {
    let roundedValue = Double(ratingSlider.value).round(nearest: Constants.sliderInterval)
    ratingSlider.value = Float(roundedValue)
    if roundedValue < 5 {
      minimumRatingLabel.text = "Minimum \(ratingSlider.value)+"
    } else {
      minimumRatingLabel.text = "Minimum \(ratingSlider.value)"
    }
  }

  @IBAction private func onePriceTapped() {
    if isOneSelected {
      unselectButton(button: onePriceButton)
      isOneSelected = false
    } else {
      selectButton(button: onePriceButton)
      isOneSelected = true
    }
  }

  @IBAction private func twoPriceTapped() {
    if isTwoSelected {
      unselectButton(button: twoPriceButton)
      isTwoSelected = false
    } else {
      selectButton(button: twoPriceButton)
      isTwoSelected = true
    }
  }

  @IBAction private func threePriceTapped() {
    if isThreeSelected {
      unselectButton(button: threePriceButton)
      isThreeSelected = false
    } else {
      selectButton(button: threePriceButton)
      isThreeSelected = true
    }
  }

  func transformPriceInput() -> [Int] {
    var prices: [Int] = []
    if isOneSelected { prices.append(1) }
    if isTwoSelected { prices.append(2) }
    if isThreeSelected { prices.append(3) }
    return prices
  }
}

// MARK: Navigation
extension RatingPriceViewController {
  func setNavigation() {
    backButton.titleLabel?.font = Font.formNavigation(size: 18)
    backButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    nextButton.titleLabel?.font = Font.formNavigation(size: 18)
    nextButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
  }

  @IBAction private func closeTapped() {
    navigationController?.popToRootViewController(animated: true)
  }

  @IBAction private func backTapped() {
    navigationController?.popViewController(animated: true)
  }

  @IBAction private func nextTapped() {
    searchQuery.minimumRating = Double(ratingSlider.value)
    searchQuery.price = transformPriceInput()
    let dietaryVC = DietaryRestrictionsViewController.viewController(searchQuery: searchQuery)
    navigationController?.pushViewController(dietaryVC, animated: true)
  }
}
