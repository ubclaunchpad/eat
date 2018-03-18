//
//  ViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class EatingTimeViewController: UIViewController {
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var restaurantHoursLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var restaurantHoursTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    headerLabel.font = Font.header(size: 13)
    headerLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    restaurantHoursLabel.font = Font.body(size: 22)
    restaurantHoursLabel.textColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
    restaurantHoursTextField.font = Font.body(size: 22)
    restaurantHoursTextField.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)

    setDatePicker()
    setDateLabel(date: "now")

  }

  private func setDatePicker() {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
    datePicker.backgroundColor = .white
    datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)

    restaurantHoursTextField.inputView = datePicker

    let toolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
    toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    
    restaurantHoursTextField.inputAccessoryView = toolbar

    setDateInput(date: "now")
  }

  @objc func datePickerChanged(sender: UIDatePicker) {
    if (sender.date.sameDate(date: Date())) {
      setDateInput(date: sender.date.toStringToday())
    }
    else {
      setDateInput(date: sender.date.toString())
    }
  }

  @objc func cancelTapped() {
    restaurantHoursTextField.resignFirstResponder()
  }

  @objc func doneTapped() {
    restaurantHoursTextField.resignFirstResponder()
  }

  private func setDateLabel(date: String) {
    dateLabel.attributedText = NSAttributedString(string: date, attributes:
      [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
  }

  private func setDateInput(date: String) {
    restaurantHoursTextField.attributedText = NSAttributedString(string: date, attributes:
      [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
  }
}

