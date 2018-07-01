//
//  RatingPriceViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-21.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import ChameleonFramework

final class RatingPriceViewController: UIViewController {
  private struct Constants {
    static let sliderInterval: Double = 0.5
  }

  @IBOutlet weak var ratingQuestionLabel: UILabel!
  @IBOutlet weak var minimumRatingLabel: UILabel!
  @IBOutlet weak var ratingSlider: EatSlider!
  @IBOutlet weak var priceLabel: UILabel!

  @IBOutlet weak var onePriceButton: UIButton!
  @IBOutlet weak var twoPriceButton: UIButton!
  @IBOutlet weak var threePriceButton: UIButton!

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  
  var viewModel: RatingPriceViewModel

  init(viewModel: RatingPriceViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    viewModel.setDefaults()
  }

  func configure() {
    ratingQuestionLabel.font = Font.header(size: 13)
    ratingQuestionLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    minimumRatingLabel.font = Font.header(size: 24)
    minimumRatingLabel.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)
    minimumRatingLabel.accessibilityIdentifier = Accessibility.ratingMinimumRating
    priceLabel.font = Font.header(size: 13)
    priceLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)

    self.view.backgroundColor = Colors.backgroundColor

    onePriceButton.layer.cornerRadius = 8
    onePriceButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    onePriceButton.backgroundColor = Colors.backgroundColor
    onePriceButton.titleLabel?.font =  Font.boldButton(size: 18)
    onePriceButton.accessibilityIdentifier = Accessibility.ratingOnePriceButton
    unselectButton(button: onePriceButton)

    twoPriceButton.layer.cornerRadius = 8
    twoPriceButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    twoPriceButton.backgroundColor = Colors.backgroundColor
    twoPriceButton.titleLabel?.font =  Font.boldButton(size: 18)
    twoPriceButton.accessibilityIdentifier = Accessibility.ratingTwoPriceButton
    unselectButton(button: twoPriceButton)

    threePriceButton.layer.cornerRadius = 8
    threePriceButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    threePriceButton.backgroundColor = Colors.backgroundColor
    threePriceButton.titleLabel?.font =  Font.boldButton(size: 18)
    threePriceButton.accessibilityIdentifier = Accessibility.ratingThreePriceButton
    unselectButton(button: threePriceButton)

    ratingQuestionLabel.text = viewModel.ratingsTitle
    priceLabel.text = viewModel.priceTitle

    backButton.titleLabel?.font = Font.formNavigation(size: 18)
    backButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    backButton.setTitle(viewModel.backButtonTitle, for: .normal)
    nextButton.titleLabel?.font = Font.formNavigation(size: 18)
    nextButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    nextButton.setTitle(viewModel.nextButtonTitle, for: .normal)
    nextButton.accessibilityIdentifier = Accessibility.ratingPriceNext

    ratingSlider.setThumbImage(#imageLiteral(resourceName: "Slider"), for: .normal)
    ratingSlider.minimumTrackTintColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    ratingSlider.maximumTrackTintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.8, alpha: 1)
    ratingSlider.maximumValue = 5
    ratingSlider.minimumValue = 0
    ratingSlider.accessibilityIdentifier = Accessibility.ratingSlider

    viewModel.onRatingChanged = setRating(value:text:)
    viewModel.onPriceChanged = setPriceButtonState(priceButton:selected:)
  }

  func setRating(value: Float, text: String) {
    ratingSlider.value = value
    minimumRatingLabel.text = text
  }

  private func setPriceButtonState(priceButton: PriceButton, selected: Bool) {
    var button: UIButton
    switch priceButton {
    case .one:
      button = onePriceButton
    case .two:
      button = twoPriceButton
    case .three:
      button = threePriceButton
    }
    if selected {
      selectButton(button: button)
    } else {
      unselectButton(button: button)
    }
  }

  private func unselectButton(button: UIButton) {
    button.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    button.layer.borderWidth = 2
    button.backgroundColor = Colors.backgroundColor
  }

  private func selectButton(button: UIButton) {
    button.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: button.frame, andColors: [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)])
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.borderWidth = 0
  }
}

// MARK: IBActions
extension RatingPriceViewController {
  @IBAction func ratingSliderChanged() {
    let roundedValue = Double(ratingSlider.value).round(nearest: Constants.sliderInterval)
    viewModel.ratingChanged(value: roundedValue)
  }

  @IBAction private func onePriceTapped() {
    viewModel.priceButtonTapped(button: .one)
  }

  @IBAction private func twoPriceTapped() {
    viewModel.priceButtonTapped(button: .two)
  }

  @IBAction private func threePriceTapped() {
    viewModel.priceButtonTapped(button: .three)
  }

  @IBAction private func didTapCloseButton() {
    viewModel.onCloseButtonTapped?()
  }

  @IBAction private func didTapBackButton() {
    viewModel.onBackButtonTapped?()
  }

  @IBAction private func didTapNextButton() {
    viewModel.didTapNext()
  }
}
