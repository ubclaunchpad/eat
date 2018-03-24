//
//  ChosenRestaurantViewController.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit

class ChosenRestaurantViewController: UIViewController {


  @IBOutlet weak var tableView: UITableView!

  var myRestaurant = Restaurant(name: "Jam Jar", rating: 4, phone: "604-152-1521", status: false, imageUrl: "www.yelp.ca", address: "", foodType: "", reviewCount: 0, distance: 0.0)

  static func viewController() -> RestaurantInfoViewController {
    let storyboard = UIStoryboard(name: "ChosenRestaurant", bundle: nil)
    guard let chosenVC = storyboard.instantiateViewController(withIdentifier: "ChosenRestaurantVC") as? RestaurantInfoViewController
      else { fatalError() }
    return chosenVC
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .singleLine
    tableView.allowsSelection = false
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
  }
}

extension ChosenRestaurantViewController: UITableViewDataSource {

  enum Section: Int {
    case photo, title, callRestaurant, exploreMenu, map

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
        tableView.dequeueReusableCell(withIdentifier: "ChosenRestaurantPhotoCell", for: indexPath) as? ChosenRestaurantPhotoCell else { fatalError() }
      return cell
    case .title:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChosenRestaurantInfoCell",for: indexPath) as? ChosenRestaurantInfoCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    case .callRestaurant:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "CallRestaurantCell",for: indexPath) as? CallRestaurantCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    case .exploreMenu:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreMenuCell",for: indexPath) as? ExploreMenuCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    case .map:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChosenRestauantMapCell",for: indexPath) as? ChosenRestaurantMapCell else { fatalError() }
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
    case .callRestaurant:
      return ""
    case .exploreMenu:
      return ""
    case .map:
      return ""
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let section = Section(rawValue: section) else { fatalError() }
    switch section {
    case .photo:
      return 1
    case .title:
      return 1
    case .callRestaurant:
      return 1
    case .exploreMenu:
      return 1
    case .map:
      return 1
    }
  }
}

extension ChosenRestaurantViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .photo:
      return 267
    case .title:
      return 145
    case .callRestaurant:
      return 51
    case .exploreMenu:
      return 51
    case .map:
      return 221
    }
  }
}
