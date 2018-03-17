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

  var myRestaurant = Restaurant(name: "Jam Jar", rating: 4, phone: "604-152-1521", status: false)

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
    case photo, title, InfoMenu, InfoAddress, reviews

    static let count = 5
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .photo:
      guard let cell =
        tableView.dequeueReusableCell(withIdentifier: "RestaurantPhotoCell", for: indexPath) as? RestaurantPhotoCell else { fatalError() }
        return cell
    case .title:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTitleCell",for: indexPath) as? RestaurantTitleCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    case .InfoMenu:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoCell",for: indexPath) as? RestaurantInfoCell else { fatalError() }
      return cell
    case .InfoAddress:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoAddressCell",for: indexPath) as? RestaurantInfoAddressCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    case .reviews:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantReviewCell",for: indexPath) as? RestaurantReviewCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let section = Section(rawValue: section) else { fatalError() }
    switch section {
    case .photo:
      return ""
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
    case .photo:
      return 1
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
    case .photo:
      return 267
    case .title:
      return 160
    case .InfoMenu:
      return 65
    case .InfoAddress:
      return 65
    case .reviews:
      return 150
    }
  }
}

