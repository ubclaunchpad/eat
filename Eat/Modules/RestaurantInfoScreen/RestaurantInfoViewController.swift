//
//  RestaurantInfoViewController.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-09.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) {
    self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T()))
  }
}
final class RestaurantInfoViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.register(UINib(nibName: "RestaurantPhotoCell", bundle: nil), forCellReuseIdentifier: "RestaurantPhotoCell")
      tableView.register(UINib(nibName: "RestaurantTitleCell", bundle: nil), forCellReuseIdentifier: "RestaurantTitleCell")
      tableView.register(UINib(nibName: "RestaurantInfoMenuCell", bundle: nil), forCellReuseIdentifier: "RestaurantInfoMenuCell")
      tableView.register(UINib(nibName: "RestaurantInfoAddressCell", bundle: nil), forCellReuseIdentifier: "RestaurantInfoAddressCell")
      tableView.register(UINib(nibName: "RestaurantReviewCell", bundle: nil), forCellReuseIdentifier: "RestaurantReviewCell")
    }
  }
  @IBOutlet weak var exitButton: UIButton!

  var viewModel: RestaurantInfoViewModel

  init(viewModel: RestaurantInfoViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    viewModel.fetchReviews()
  }

  func configure() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .singleLine
    let headerInset: CGFloat = 24
    tableView.separatorInset = UIEdgeInsets.init(top: 0, left: headerInset, bottom: 0, right: 0)

    self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)

    viewModel.onReviewsUpdated = updateViews
  }

  func updateViews() {
    tableView.reloadSections(IndexSet(integer: Section.reviews.rawValue), with: .none)
  }
}

extension RestaurantInfoViewController: UITableViewDataSource {
  enum Section: Int {
    case photo, title, infoMenu, infoAddress, reviews

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
      cell.configure(with: viewModel.photoViewModel(at: indexPath))
      return cell
    case .title:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTitleCell",for: indexPath) as? RestaurantTitleCell else { fatalError() }
      cell.configure(with: viewModel.titleViewModel(at: indexPath))
      return cell
    case .infoMenu:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoMenuCell",for: indexPath) as? RestaurantInfoMenuCell else { fatalError() }
      cell.configure(with: viewModel.infoMenuViewModel(at: indexPath))
      return cell
    case .infoAddress:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoAddressCell",for: indexPath) as? RestaurantInfoAddressCell else { fatalError() }
      cell.configure(with: viewModel.infoAddressViewModel(at: indexPath))
      return cell
    case .reviews:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantReviewCell",for: indexPath) as? RestaurantReviewCell else { fatalError() }
      cell.configure(with: viewModel.reviewViewModel(at: indexPath))
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
    case .infoMenu:
      return viewModel.infoHeader
    case .infoAddress:
      return ""
    case .reviews:
      return viewModel.reviewsHeader
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
    case .infoMenu:
      return 1
    case .infoAddress:
      return 1
    case .reviews:
      return viewModel.numberOfReviews
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
    case .infoMenu:
      return 40
    case .infoAddress:
      return 40
    case .reviews:
      return 115
    }
  }

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    switch section {
    case .photo:
      break
    case .title:
      break
    case .infoMenu:
      viewModel.selectInfoMenu()
    case .infoAddress:
      break
    case .reviews:
      break
    }
  }
}

// MARK: IBActions
extension RestaurantInfoViewController {
  @IBAction func exitButtonPressed() {
    viewModel.onExitButtonTapped?()
  }
}
