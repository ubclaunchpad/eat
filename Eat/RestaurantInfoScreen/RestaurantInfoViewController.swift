//
//  RestaurantInfoViewController.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-09.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit

class RestaurantInfoViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  static func viewController() -> RestaurantInfoViewController {
    let storyboard = UIStoryboard(name: "RestaurantInfoStoryboard", bundle: nil)
    guard let restaurantVC = storyboard.instantiateViewController(withIdentifier: "RestaurantInfoVC") as? RestaurantInfoViewController
      else { fatalError() }
    return restaurantVC
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .singleLine
    tableView.allowsSelection = false
  }
}

extension RestaurantInfoViewController: UITableViewDataSource {

  enum Section: Int {
    case title, InfoMenu, InfoAddress, reviews

    static let count = 4
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .title:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTitleCell",for: indexPath) as? RestaurantTitleCell else { fatalError() }
      cell.configure()
      return cell
    case .InfoMenu:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoCell",for: indexPath) as? RestaurantInfoCell else { fatalError() }
      return cell
    case .InfoAddress:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoAddressCell",for: indexPath) as? RestaurantInfoAddressCell else { fatalError() }
      cell.configure()
      return cell
    case .reviews:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantReviewCell",for: indexPath) as? RestaurantReviewCell else { fatalError() }
      cell.configure()
      return cell
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let section = Section(rawValue: section) else { fatalError() }
    switch section {
    case .title:
      return ""
    case .InfoMenu:
      return "Info"
    case .InfoAddress:
      return ""
    case .reviews:
      return "Reviews"
  }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let section = Section(rawValue: section) else { fatalError() }
    switch section {
    case .title:
      return 1
    case .InfoMenu:
      return 1
    case .InfoAddress:
      return 1
    case .reviews:
      return 5
    }
  }

}

extension RestaurantInfoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .title:
      return 150
    case .InfoMenu:
      return 70
    case .InfoAddress:
      return 70
    case .reviews:
      return 150
    }
  }
}

