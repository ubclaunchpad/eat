//
//  ChosenRestaurantViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class ChosenRestaurantViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.register(RestaurantPhotoCell.self)
      tableView.register(RestaurantTitleCell.self)
      tableView.register(RestaurantPhoneCell.self)
      tableView.register(RestaurantExploreMenuCell.self)
      tableView.register(RestaurantMapCell.self)
    }
  }
  @IBOutlet weak var headerLabel: UILabel!

  fileprivate var viewModel: ChosenRestaurantViewModel

  init(viewModel: ChosenRestaurantViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }

  func configure() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .singleLine

    view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)

    headerLabel.font = Font.navigationHeaders(size: 18)
    headerLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  }
}

// MARK: IBActions
extension ChosenRestaurantViewController {
  @IBAction func exitTapped() {
    viewModel.onExitButtonTapped?()
  }
}

extension ChosenRestaurantViewController: UITableViewDataSource {
  enum Section: Int {
    case photo, title, phone, exploreMenu, map

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
    case .phone:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantPhoneCell",for: indexPath) as? RestaurantPhoneCell else { fatalError() }
      cell.configure(with: viewModel.phoneViewModel(at: indexPath))
      return cell
    case .exploreMenu:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantExploreMenuCell",for: indexPath) as? RestaurantExploreMenuCell else { fatalError() }
      cell.configure(with: viewModel.menuViewModel(at: indexPath))
      return cell
    case .map:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantMapCell",for: indexPath) as? RestaurantMapCell else { fatalError() }
      cell.configure(with: viewModel.mapViewModel(at: indexPath))
      return cell
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let section = Section(rawValue: section) else { fatalError() }
    switch section {
    case .photo:
      return 1
    case .title:
      return 1
    case .phone:
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
      return 130
    case .phone:
      return 51
    case .exploreMenu:
      return 51
    case .map:
      return 225
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
    case .phone:
      viewModel.selectCall()
    case .exploreMenu:
      viewModel.selectExploreMenu()
    case .map:
      break
    }
  }
}
