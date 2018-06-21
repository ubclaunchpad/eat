//
//  PeopleCountViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-20.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class PeopleCountViewController: UIViewController {
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var countButton: UIButton!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var subheaderLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!

  var viewModel: PeopleCountViewModel

  init(viewModel: PeopleCountViewModel) {
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
    countButton.layer.shadowColor = #colorLiteral(red: 0.8705882353, green: 0.6901960784, blue: 0.4784313725, alpha: 1)
    countButton.layer.shadowOffset = CGSize(width: 7, height: 14)
    countButton.layer.masksToBounds = false
    countButton.layer.shadowRadius = 16.0
    countButton.layer.shadowOpacity = 0.5
    countButton.layer.cornerRadius = 0.5 * countButton.frame.width

    minusButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    minusButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    minusButton.layer.masksToBounds = false
    minusButton.layer.shadowRadius = 1.0
    minusButton.layer.shadowOpacity = 0.25
    minusButton.backgroundColor = #colorLiteral(red: 0.9621867069, green: 0.9621867069, blue: 0.9621867069, alpha: 1)
    minusButton.layer.borderColor = #colorLiteral(red: 0.908728585, green: 0.908728585, blue: 0.908728585, alpha: 1)
    minusButton.layer.borderWidth = 1.0
    minusButton.layer.cornerRadius = 0.5 * minusButton.frame.width

    headerLabel.font = Font.header(size: 13)
    headerLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    subheaderLabel.font = Font.body(size: 22)
    subheaderLabel.textColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    countLabel.font = Font.header(size: 32)

    backButton.titleLabel?.font = Font.formNavigation(size: 18)
    backButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)
    nextButton.titleLabel?.font = Font.formNavigation(size: 18)
    nextButton.setTitleColor(#colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1), for: .normal)

    viewModel.onNumberOfPeopleChange = scaleButton(animated:to:)
  }

  private func scaleButton(animated: Bool = true, to numberOfPeople: Int) {
    countLabel.text = String(numberOfPeople)
    let fontSize = CGFloat(25 + numberOfPeople * 7)
    countLabel.font = Font.header(size: fontSize)
    let scale = 1.0 + Double(numberOfPeople) / 7.0 * Double(numberOfPeople) / 10.0

    if animated {
      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
        self.countButton.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
      }, completion: nil)
    } else {
      self.countButton.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
    }
  }
}

// MARK: IBActions
extension PeopleCountViewController {
  @IBAction private func didTapCountButton() {
    viewModel.increasePeople()
  }

  @IBAction private func didTapMinusButton() {
    viewModel.decreasePeople()
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
