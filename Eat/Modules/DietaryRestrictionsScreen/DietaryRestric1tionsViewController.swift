//
//  DietaryRestrictionsViewController.swift
//  Eat
//
//  Created by Sepand on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import ChameleonFramework

class DietaryRestrictionsViewController: UIViewController {
  @IBOutlet weak var restrictionQuestion: UILabel!
  @IBOutlet weak var VeganButton: UIButton!
  @IBOutlet weak var halalButton: UIButton!
  @IBOutlet weak var VegetarianButton: UIButton!

  @IBOutlet weak var preferenceQuestion: UILabel!
  @IBOutlet weak var OtherPrefs: UITextField!
  @IBOutlet weak var preferenceLine: UIView!

  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var finishButton: UIButton!

  static func viewController(searchQuery: SearchQuery) -> DietaryRestrictionsViewController {
    let storyboard = UIStoryboard(name: "DietaryRestrictionsScreen", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DietaryRestrictionsViewController") as? DietaryRestrictionsViewController
      else { fatalError() }
    vc.searchQuery = searchQuery
    return vc
  }

  var searchQuery: SearchQuery!

  var dietary: DietaryRestriction = .none {
    didSet {
      switch dietary {
      case .vegan:
        resetAll()
        selectButton(button: VeganButton)
      case .halal:
        resetAll()
        selectButton(button: halalButton)
      case .vegetarian:
        resetAll()
        selectButton(button: VegetarianButton)
      case .none:
        resetAll()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyling()
    resetAll()
    setNavigation()
    setDefaults()

    VeganButton.setTitle("Vegan", for: .normal)
    VegetarianButton.setTitle("Vegetarian", for: .normal)
    halalButton.setTitle("Halal", for: .normal)

    OtherPrefs.delegate = self
    OtherPrefs.placeholder = "Eg: French, bubble tea"

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  private func setDefaults() {
    dietary = searchQuery.dietary
    OtherPrefs.placeholder = searchQuery.searchTerm.isEmpty ? "Eg: Vietnamese, bubble tea" : searchQuery.searchTerm
  }

  private func applyStyling() {
    restrictionQuestion.font = Font.header(size: 13)
    restrictionQuestion.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    preferenceQuestion.font = Font.header(size: 13)
    preferenceQuestion.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    OtherPrefs.font = Font.body(size: 24)
    OtherPrefs.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)
    OtherPrefs.tintColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)

    // Vegan
    VeganButton.layer.cornerRadius = 8
    VeganButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    VeganButton.titleLabel?.font =  Font.button(size: 16)

    // Vegetarian
    VegetarianButton.layer.cornerRadius = 8
    VegetarianButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    VegetarianButton.titleLabel?.font = Font.button(size: 16)

    // None
    halalButton.layer.cornerRadius = 8
    halalButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    halalButton.titleLabel?.font = Font.button(size: 16)

    preferenceLine.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  private func unselectButton(button: UIButton) {
    button.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    button.layer.borderWidth = 2
    button.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
  }

  private func selectButton(button: UIButton) {
    button.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: button.frame, andColors: [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)])
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.borderWidth = 0
  }

  @IBAction func VeganButtonPress(_ sender: Any) {
    dietary = .vegan
  }

  @IBAction func VegetarianButtonPress(_ sender: UIButton) {
    dietary = .vegetarian
  }

  @IBAction func halalButtonPress(_ sender: Any) {
    dietary = .halal
  }

  private func resetAll() {
    unselectButton(button: VeganButton)
    unselectButton(button: VegetarianButton)
    unselectButton(button: halalButton)
  }
}

extension DietaryRestrictionsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let restaurantCardsVC = RestaurantCardSelectionViewController.viewController(searchQuery: searchQuery)
    navigationController?.pushViewController(restaurantCardsVC, animated: true)
    return true
  }
}

// MARK: Navigation
extension DietaryRestrictionsViewController {
  func setNavigation() {
    backButton.titleLabel?.font = Font.formNavigation(size: 18)
    backButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    finishButton.titleLabel?.font = Font.formNavigation(size: 18)
    finishButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
  }

  @IBAction private func closeTapped() {
    navigationController?.popToRootViewController(animated: true)
  }

  @IBAction private func backTapped() {
    navigationController?.popViewController(animated: true)
  }

  @IBAction private func finishTapped() {
    searchQuery.dietary = dietary
    searchQuery.searchTerm = OtherPrefs.text ?? ""
    let restaurantCardsVC = RestaurantCardSelectionViewController.viewController(searchQuery: searchQuery)
    navigationController?.pushViewController(restaurantCardsVC, animated: true)
  }
}
