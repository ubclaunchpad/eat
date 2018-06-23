//
//  MealTimeViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-21.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class MealTimeViewController: UIViewController {
  fileprivate struct Constants {
    static let minuteInterval = 5
  }

  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var restaurantHoursTextView: UITextView!
  @IBOutlet weak var bottomGradientView: UIView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!

  fileprivate var viewModel: MealTimeViewModel

  let datePicker = UIDatePicker()

  init(viewModel: MealTimeViewModel) {
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
    headerLabel.font = Font.header(size: 13)
    headerLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    headerLabel.text = viewModel.headerTitle
    restaurantHoursTextView.tintColor = .clear
    restaurantHoursTextView.backgroundColor = .clear
    restaurantHoursTextView.textContainerInset = UIEdgeInsets.zero
    restaurantHoursTextView.textContainer.lineFragmentPadding = 0

    bottomGradientView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: bottomGradientView.frame, andColors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0), #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)])

    backButton.titleLabel?.font = Font.formNavigation(size: 18)
    backButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    backButton.setTitle(viewModel.backButtonTitle, for: .normal)
    nextButton.titleLabel?.font = Font.formNavigation(size: 18)
    nextButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    nextButton.setTitle(viewModel.nextButtonTitle, for: .normal)

    self.view.backgroundColor = Colors.backgroundColor

    datePicker.datePickerMode = .dateAndTime
    datePicker.backgroundColor = .white
    datePicker.minuteInterval = Constants.minuteInterval
    datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)

    restaurantHoursTextView.inputView = datePicker

    let toolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: viewModel.doneToolbarTitle, style: .done, target: self, action: #selector(doneTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: viewModel.nowToolbarTitle, style: .plain, target: self, action: #selector(nowTapped))
    toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true

    restaurantHoursTextView.inputAccessoryView = toolbar

    viewModel.onSelectedDateChanged = setDate(date:)
  }

  @objc func nowTapped() {
    datePicker.date = Date()
    viewModel.dateChanged(newTime: .now)
  }

  @objc func datePickerChanged() {
    if datePicker.date < Date() {
      datePicker.date = Date()
      viewModel.dateChanged(newTime: .now)
    } else {
      viewModel.dateChanged(newTime: .later(date: datePicker.date))
    }
  }

  @objc func doneTapped() {
    restaurantHoursTextView.resignFirstResponder()
  }

  private func setDate(date: String) {
    let displayString = NSMutableAttributedString()
    let staticText = NSAttributedString(string: viewModel.restaurantHoursHeader, attributes:
      [.font: Font.body(size: 22),
       .foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)])
    let datePickerText = NSAttributedString(string: date, attributes:
      [.font:  Font.body(size: 22),
       .underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
       .foregroundColor: #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)])
    displayString.append(staticText)
    displayString.append(datePickerText)
    restaurantHoursTextView.attributedText = displayString
  }
}

// MARK: IBActions
extension MealTimeViewController {
  @IBAction private func closeTapped() {
    viewModel.onCloseButtonTapped?()
  }

  @IBAction private func backTapped() {
    viewModel.onBackButtonTapped?()
  }

  @IBAction private func nextTapped() {
    viewModel.didTapNext()
  }
}
