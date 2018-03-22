//
//  PeopleCountViewController.swift
//  Eat
//
//  Created by Sarina Chen on 2018-02-16.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class PeopleCountViewController: UIViewController {
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var countButton: UIButton!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var subheaderLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!

//  YONNI uncomment this
  static func viewController(searchQuery: SearchQuery) -> PeopleCountViewController {
    let storyboard = UIStoryboard(name: "PeopleCountScreen", bundle: nil)

    guard let vc = storyboard.instantiateViewController(withIdentifier: "PeopleCountViewController") as? PeopleCountViewController
      else { fatalError() }

    vc.searchQuery = searchQuery

    return vc
  }

  // YONNI delete this
//  static func viewController() -> UINavigationController {
//    let storyboard = UIStoryboard(name: "PeopleCountScreen", bundle: nil)
//    guard let navigationVC = storyboard.instantiateInitialViewController() as? UINavigationController else { fatalError() }
//    return navigationVC
//  }

  var searchQuery: SearchQuery = SearchQuery()

  var peopleCount: Int = 1

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    setupButtons()
    setupLabels()
    setNavigation()
  }

  @IBAction func countButtonTapped(_ sender: Any) {
    if peopleCount < 10 {
      peopleCount += 1
      scaleButton()
    }
  }

  @IBAction func minusButtonTapped(_ sender: Any) {
    if peopleCount > 1 {
      peopleCount -= 1
      scaleButton()
    }
  }

  private func setupButtons() {
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
  }

  private func scaleButton() {
    countLabel.text = String(peopleCount)
    let fontSize = CGFloat(25 + peopleCount * 7)
    countLabel.font = Font.header(size: fontSize)
    let scale = 1.0 + Double(self.peopleCount) / 7.0 * Double(self.peopleCount) / 10.0
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
      self.countButton.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
    }, completion: nil)
  }

  private func setupLabels() {
    headerLabel.font = Font.header(size: 13)
    headerLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    subheaderLabel.font = Font.body(size: 22)
    subheaderLabel.textColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    countLabel.font = Font.header(size: 32)
  }
}

// MARK: Navigation
extension PeopleCountViewController {
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
    searchQuery.numberOfPeople = peopleCount
    let eatingTimeVC = EatingTimeViewController.viewController(searchQuery: searchQuery)
    navigationController?.pushViewController(eatingTimeVC, animated: true)
  }
}
