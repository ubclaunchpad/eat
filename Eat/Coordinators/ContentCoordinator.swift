//
//  ContentCoordinator.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

protocol ContentCoordinatorDelegate: class {
  func contentCoordinatorDidFinish(_ coordinator: ContentCoordinator)
}

final class ContentCoordinator: Coordinator {
  fileprivate weak var delegate: ContentCoordinatorDelegate?
  fileprivate let navigationController: UINavigationController
  fileprivate let fromViewController: UIViewController

  init(delegate: ContentCoordinatorDelegate, navigationController: UINavigationController, from viewController: UIViewController) {
    self.delegate = delegate
    self.navigationController = navigationController
    self.fromViewController = viewController
  }

  func start() {
    let viewModel = MapViewModelImpl()
    viewModel.onTapNext = showPeopleCount(searchQuery:)
    let mapViewController = MapViewController(viewModel: viewModel)
    navigationController.viewControllers = [mapViewController]
    navigationController.setNavigationBarHidden(true, animated: false)
    fromViewController.present(navigationController, animated: true, completion: nil)
  }
}

// MARK: View Controller Instantiations
extension ContentCoordinator {
  func instantiatePeopleCount(searchQuery: SearchQuery) -> PeopleCountViewController {
    let viewModel = PeopleCountViewModelImpl(searchQuery: searchQuery)
    let vc = PeopleCountViewController(viewModel: viewModel)

    viewModel.onNextButtonTapped = { searchQuery in
      self.showMealTime(viewController: vc, searchQuery: searchQuery)
    }
    viewModel.onBackButtonTapped = goBack
    viewModel.onCloseButtonTapped = close

    return vc
  }

  func instantiateMealTime(searchQuery: SearchQuery) -> MealTimeViewController {
    let viewModel = MealTimeViewModelImpl(searchQuery: searchQuery)
    let vc = MealTimeViewController(viewModel: viewModel)

    viewModel.onNextButtonTapped = { searchQuery in
      self.showRatingPrice(viewController: vc, searchQuery: searchQuery)
    }
    viewModel.onBackButtonTapped = goBack
    viewModel.onCloseButtonTapped = close

    return vc
  }

  func instantiateRatingPrice(searchQuery: SearchQuery) -> RatingPriceViewController {
    let viewModel = RatingPriceViewModelImpl(searchQuery: searchQuery)
    let vc = RatingPriceViewController(viewModel: viewModel)

    viewModel.onNextButtonTapped = { searchQuery in
//      self.showMealTime(viewController: vc, searchQuery: searchQuery)
    }
    viewModel.onBackButtonTapped = goBack
    viewModel.onCloseButtonTapped = close

    return vc
  }
}

// MARK: Routing
extension ContentCoordinator {
  func showPeopleCount(searchQuery: SearchQuery) {
    let vc = instantiatePeopleCount(searchQuery: searchQuery)
    navigationController.pushViewController(vc, animated: true)
  }

  func showMealTime(viewController: PeopleCountViewController, searchQuery: SearchQuery) {
    let vc = instantiateMealTime(searchQuery: searchQuery)
    navigationController.pushViewController(vc, animated: true)
  }

  func showRatingPrice(viewController: MealTimeViewController, searchQuery: SearchQuery) {
    let vc = instantiateRatingPrice(searchQuery: searchQuery)
    navigationController.pushViewController(vc, animated: true)
  }

  func goBack() {
    _ = navigationController.popViewController(animated: true)
  }

  func close() {
    _ = navigationController.popToRootViewController(animated: true)
  }
}
