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

  var myRestaurant = Restaurant(name: "Jam Jar", rating: 4, phone: "604-152-1521", status: false, imageUrl: "www.yelp.ca", address: "", foodType: "", reviewCount: 0, distance: 0.0, id: "", yelpUrl: "")

  static func viewController() -> RestaurantInfoViewController {
    let storyboard = UIStoryboard(name: "ChosenRestaurantStoryboard", bundle: nil)
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
  }
}

extension ChosenRestaurantViewController: UITableViewDataSource {

  enum Section: Int {
    case photo, title, map, buttons

    static let count = 4
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
    case .map:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChosenRestauantMapCell",for: indexPath) as? ChosenRestaurantMapCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      return cell
    case .buttons:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapButtonsCell",for: indexPath) as? MapButtonsCell else { fatalError() }
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
    case .map:
      return ""
    case .buttons:
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
    case .map:
      return 1
    case .buttons:
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
      return 160
    case .map:
      return 300
    case .buttons:
      return 260
    }
  }
}
