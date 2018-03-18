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
  @IBOutlet weak var None: UIButton!
  @IBOutlet weak var VegetarianButton: UIButton!

  @IBOutlet weak var preferenceQuestion: UILabel!
  @IBOutlet weak var OtherPrefs: UITextField!
  @IBOutlet weak var preferenceLine: UIView!

  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var finishButton: UIButton!

  var vegan = false
  var vegetarian = false
  var none = false

  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyling()
    resetAll()
    setNavigation()

    VeganButton.setTitle("Vegan", for: .normal)
    VegetarianButton.setTitle("Vegetarian", for: .normal)
    None.setTitle("None", for: .normal)

    OtherPrefs.delegate = self
    OtherPrefs.placeholder = "Eg: Vietnamese, bubble tea"

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  func applyStyling() {
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
    None.layer.cornerRadius = 8
    None.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    None.titleLabel?.font = Font.button(size: 16)

    preferenceLine.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  @IBAction func VeganButtonPress(_ sender: Any) {
    if (vegan) {
      resetAll()
    } else {
      resetAll()
      VeganButton.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom, withFrame: VeganButton.frame, andColors: [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)])
      VeganButton.setTitleColor(UIColor.white, for: .normal)
      VeganButton.layer.borderWidth = 0
      vegan = true
    }
  }

  @IBAction func VegetarianButtonPress(_ sender: UIButton) {
    if (vegetarian) {
      resetAll()
    } else {
      resetAll()
      VegetarianButton.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom, withFrame: VegetarianButton.frame, andColors: [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)])
      VegetarianButton.setTitleColor(UIColor.white, for: .normal)
      VegetarianButton.layer.borderWidth = 0
      vegetarian = true
    }
  }

  @IBAction func NoneButtonPress(_ sender: Any) {
    if (none) {
      resetAll()
    } else {
      resetAll()
      None.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom, withFrame: None.frame, andColors: [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)])
      None.setTitleColor(UIColor.white, for: .normal)
      None.layer.borderWidth = 0
      none = true
    }
  }

  func resetAll() {
    vegan = false
    vegetarian = false
    none = false
    VeganButton.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    VeganButton.layer.borderWidth = 2
    VeganButton.backgroundColor = UIColor.white

    VegetarianButton.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    VegetarianButton.layer.borderWidth = 2
    VegetarianButton.backgroundColor = UIColor.white

    None.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    None.layer.borderWidth = 2
    None.backgroundColor = UIColor.white
  }
}

extension DietaryRestrictionsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // TODO: segue to next screen
    print("segue")
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

  }
}
