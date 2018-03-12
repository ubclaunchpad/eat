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
    case title, Info, reviews

    static let count = 3
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .title:
      print("Before Creating Cell")
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTitleCell",for: indexPath) as? RestaurantTitleCell else { fatalError() }
      cell.configure()
      return cell
    case .Info:
      return UITableViewCell()
    case .reviews:
      return UITableViewCell()
    }
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

}

extension RestaurantInfoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .title:
      return 200
    case .Info:
      return UITableViewAutomaticDimension
    case .reviews:
      return UITableViewAutomaticDimension
    }
  }
}

