//
//  RestaurantInfoViewController.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-09.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class RestaurantInfoViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var exitButton: UIButton!

  static func viewController(restaurant: Restaurant) -> RestaurantInfoViewController {
    let storyboard = UIStoryboard(name: "RestaurantInfoScreen", bundle: nil)
    guard let restaurantVC = storyboard.instantiateViewController(withIdentifier: "RestaurantInfoVC") as? RestaurantInfoViewController
      else { fatalError() }
    restaurantVC.myRestaurant = restaurant
    return restaurantVC
  }

  var myRestaurant = Restaurant(name: "", rating: 0, phone: "", status: false, imageUrl: "", address: "", foodType: "", reviewCount: 0, distance: 0.0, id: "", yelpUrl: "", lat: 0, lon: 0)
  let dataManager = DataManager.default
  var reviews: [Review] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .singleLine
    let headerInset: CGFloat = 24
    tableView.separatorInset = UIEdgeInsets.init(top: 0, left: headerInset, bottom: 0, right: 0)
    self.getReviews()
    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
  }

  @IBAction func exitButtonPressed(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  func getReviews(){
    dataManager.fetchReviews(with: myRestaurant.id)
      .onSuccess { rev in
        self.reviews = rev
        self.tableView.reloadSections(IndexSet(integer: Section.reviews.rawValue), with: .none)
      }.onFailure { error in
        print(error)
    }
  }

  func openInSafari() {
    if let url = URL(string: myRestaurant.yelpUrl) {
      let config = SFSafariViewController.Configuration()
      config.entersReaderIfAvailable = true

      let vc = SFSafariViewController(url: url, configuration: config)
      present(vc, animated: true)
    }
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
      cell.configure(imageUrl: myRestaurant.imageUrl)
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      return cell
    case .title:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTitleCell",for: indexPath) as? RestaurantTitleCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      return cell
    case .InfoMenu:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoCell",for: indexPath) as? RestaurantInfoCell else { fatalError() }
      return cell
    case .InfoAddress:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoAddressCell",for: indexPath) as? RestaurantInfoAddressCell else { fatalError() }
      cell.configure(restaurant: myRestaurant)
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      return cell
    case .reviews:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantReviewCell",for: indexPath) as? RestaurantReviewCell else { fatalError() }
      cell.configure(review: reviews[indexPath.row])
      cell.selectionStyle = UITableViewCellSelectionStyle.none
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
      return "INFO"
    case .InfoAddress:
      return ""
    case .reviews:
      return "REVIEWS"
    }
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.textColor = #colorLiteral(red: 0.5107896924, green: 0.5111948848, blue: 0.5108524561, alpha: 1)
    header.textLabel?.font = Font.boldButton(size: 10)
    header.textLabel?.frame = header.frame
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
      return reviews.count
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
      return 130
    case .InfoMenu:
      return 40
    case .InfoAddress:
      return 40
    case .reviews:
      return 115
    }
  }

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .photo:
      print("Selected photo")
    case .title:
      print("Selected title")
    case .InfoMenu:
      openInSafari()
    case .InfoAddress:
      print("Selected address")
    case .reviews:
      print("Selected Reviews")
    }
  }
}

