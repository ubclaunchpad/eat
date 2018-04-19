//
//  ViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import ChameleonFramework

class EatingTimeViewController: UIViewController {
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var restaurantHoursLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var restaurantHoursTextField: UITextField!
  @IBOutlet weak var bottomGradientView: UIView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!

  static func viewController(searchQuery: SearchQuery) -> EatingTimeViewController {
    let storyboard = UIStoryboard(name: "EatingTime", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "EatingTimeViewController") as? EatingTimeViewController
      else { fatalError() }
    vc.searchQuery = searchQuery
    return vc
  }

  var searchQuery: SearchQuery!
  let datePicker = UIDatePicker()
  var selectedDate: EatingTime = .now {
    didSet {
      switch selectedDate {
      case .now:
        setDateInput(date: "now")
      case .later(let date):
        if (date.sameDate(date: Date())) {
          setDateInput(date: date.toStringToday())
        } else {
          setDateInput(date: date.toString())
        }
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyling()
    setDatePicker()
    setGradient()
    setNavigation()
    setDefaults()
  }

  private func setDefaults() {
    selectedDate = searchQuery.eatingTime
  }

  private func applyStyling() {
    headerLabel.font = Font.header(size: 13)
    headerLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    restaurantHoursLabel.font = Font.body(size: 22)
    restaurantHoursLabel.textColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
    restaurantHoursTextField.font = Font.body(size: 22)
    restaurantHoursTextField.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)
    restaurantHoursTextField.tintColor = .clear
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
  }

  private func setGradient() {
    bottomGradientView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: bottomGradientView.frame, andColors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0), #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)])
  }

  private func setDatePicker() {
    datePicker.datePickerMode = .dateAndTime
    datePicker.backgroundColor = .white
    datePicker.minuteInterval = 5
    datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)

    restaurantHoursTextField.inputView = datePicker

    let toolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Now", style: .plain, target: self, action: #selector(nowTapped))
    toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    
    restaurantHoursTextField.inputAccessoryView = toolbar

    setDateInput(date: "now")
  }

  @objc func datePickerChanged() {
    if datePicker.date < Date() {
      datePicker.date = Date()
    }
    selectedDate = .later(date: datePicker.date)
    
    if (datePicker.date.sameDate(date: Date())) {
      setDateInput(date: datePicker.date.toStringToday())
    } else if datePicker.date < Date() {
      datePicker.date = Date()
    }
    else {
      setDateInput(date: datePicker.date.toString())
    }

  }

  @objc func nowTapped() {
    datePicker.date = Date()
    selectedDate = .now
  }

  @objc func doneTapped() {
    restaurantHoursTextField.resignFirstResponder()
  }

  private func setDateInput(date: String) {
    restaurantHoursTextField.attributedText = NSAttributedString(string: date, attributes:
      [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
  }
}

// MARK: Navigation
extension EatingTimeViewController {
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
    searchQuery.eatingTime = selectedDate
    let ratingPriceVC = RatingPriceViewController.viewController(searchQuery: searchQuery)
    navigationController?.pushViewController(ratingPriceVC, animated: true)
  }
}
