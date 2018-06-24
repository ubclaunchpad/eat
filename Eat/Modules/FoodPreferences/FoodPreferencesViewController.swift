//
//  FoodPreferencesViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-22.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import ChameleonFramework

final class FoodPreferencesViewController: UIViewController {
  @IBOutlet weak var restrictionHeader: UILabel!
  @IBOutlet weak var veganButton: UIButton!
  @IBOutlet weak var halalButton: UIButton!
  @IBOutlet weak var vegetarianButton: UIButton!

  @IBOutlet weak var preferenceHeader: UILabel!
  @IBOutlet weak var preferenceTextField: UITextField!
  @IBOutlet weak var preferenceLine: UIView!

  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var finishButton: UIButton!

  var viewModel: FoodPreferencesViewModel

  init(viewModel: FoodPreferencesViewModel) {
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
    restrictionHeader.font = Font.header(size: 13)
    restrictionHeader.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)

    preferenceHeader.font = Font.header(size: 13)
    preferenceHeader.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    preferenceTextField.font = Font.body(size: 24)
    preferenceTextField.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)
    preferenceTextField.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    preferenceTextField.delegate = self

    // Vegan
    veganButton.layer.cornerRadius = 8
    veganButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    veganButton.backgroundColor = Colors.backgroundColor
    veganButton.titleLabel?.font =  Font.button(size: 16)
    veganButton.setTitle(viewModel.veganButtonTitle, for: .normal)

    // Vegetarian
    vegetarianButton.layer.cornerRadius = 8
    vegetarianButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    vegetarianButton.backgroundColor = Colors.backgroundColor
    vegetarianButton.titleLabel?.font = Font.button(size: 16)
    vegetarianButton.setTitle(viewModel.vegetarianButtonTitle, for: .normal)

    // None
    halalButton.layer.cornerRadius = 8
    halalButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    halalButton.backgroundColor = Colors.backgroundColor
    halalButton.titleLabel?.font = Font.button(size: 16)
    halalButton.setTitle(viewModel.halalButtonTitle, for: .normal)

    preferenceLine.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)

    self.view.backgroundColor = Colors.backgroundColor

    backButton.titleLabel?.font = Font.formNavigation(size: 18)
    backButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    backButton.setTitle(viewModel.backButtonTitle, for: .normal)
    finishButton.titleLabel?.font = Font.formNavigation(size: 18)
    finishButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    finishButton.setTitle(viewModel.finishButtonTitle, for: .normal)

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)

    viewModel.onDietaryChanged = setDietary(dietary:)
    viewModel.onPreferenceChanged = setPreference(preference:)
    viewModel.onDefaultPreference = setPreferencePlaceholder
  }

  func setDietary(dietary: DietaryRestriction) {
    resetAll()
    switch dietary {
    case .vegan:
      selectButton(button: veganButton)
    case .vegetarian:
      selectButton(button: vegetarianButton)
    case .halal:
      selectButton(button: halalButton)
    case .none:
      break
    }
  }

  func setPreference(preference: String) {
    preferenceTextField.text = preference
  }

  func setPreferencePlaceholder() {
    preferenceTextField.placeholder = viewModel.preferenceTextFieldPlaceholder
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

  private func resetAll() {
    unselectButton(button: veganButton)
    unselectButton(button: vegetarianButton)
    unselectButton(button: halalButton)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

extension FoodPreferencesViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    viewModel.preferenceChanged(preference: textField.text ?? "")
    viewModel.didTapFinish()
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let text = textField.text,
      let textRange = Range(range, in: text) {
      let updatedText = text.replacingCharacters(in: textRange,
                                                 with: string)
      if updatedText.isEmpty {
        textField.placeholder = viewModel.preferenceTextFieldPlaceholder
      }
    }
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    viewModel.preferenceChanged(preference: textField.text ?? "")
  }
}

// MARK: IBActions
extension FoodPreferencesViewController {
  @IBAction private func didTapVeganButton() {
    viewModel.dietaryChanged(dietary: .vegan)
  }

  @IBAction private func didTapVegetarianButton() {
    viewModel.dietaryChanged(dietary: .vegetarian)
  }

  @IBAction private func didTapHalalButton() {
    viewModel.dietaryChanged(dietary: .halal)
  }

  @IBAction private func didTapCloseButton() {
    viewModel.onCloseButtonTapped?()
  }

  @IBAction private func didTapBackButton() {
    viewModel.onBackButtonTapped?()
  }

  @IBAction private func didTapFinishButton() {
    viewModel.preferenceChanged(preference: preferenceTextField.text ?? "")
    viewModel.didTapFinish()
  }
}
