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
      self.showFoodPreferences(viewController: vc, searchQuery: searchQuery)
    }
    viewModel.onBackButtonTapped = goBack
    viewModel.onCloseButtonTapped = close

    return vc
  }

  func instantiateFoodPreferences(searchQuery: SearchQuery) -> FoodPreferencesViewController {
    let viewModel = FoodPreferencesViewModelImpl(searchQuery: searchQuery)
    let vc = FoodPreferencesViewController(viewModel: viewModel)

    viewModel.onFinishButtonTapped = { searchQuery in
      self.showRestaurantCardSelection(viewController: vc, searchQuery: searchQuery)
    }
    viewModel.onBackButtonTapped = goBack
    viewModel.onCloseButtonTapped = close

    return vc
  }

  func instantiateRestaurantCardSelection(searchQuery: SearchQuery) -> RestaurantCardSelectionViewController {
    let viewModel = RestaurantCardSelectionViewModelImpl(searchQuery: searchQuery)
    let vc = RestaurantCardSelectionViewController(viewModel: viewModel)

    viewModel.onNoRestaurantsError = { error in
      self.restaurantCardSelection(vc, failedWith: error)
    }
    viewModel.onRestaurantTapped = { restaurant in

    }
    viewModel.onFinalRestaurantSelected = { restaurant in
      
    }
    viewModel.onCloseButtonTapped = close

    return vc
  }

  func instantiateNoRestaurantError() -> NoRestaurantFoundViewController {
    let viewModel = NoRestaurantFoundViewModelImpl()
    let vc = NoRestaurantFoundViewController(viewModel: viewModel)

    viewModel.onAdjustPreferencesTapped = {
      self.noRestaurantViewControllerFinished(vc)
    }

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

  func showFoodPreferences(viewController: RatingPriceViewController, searchQuery: SearchQuery) {
    let vc = instantiateFoodPreferences(searchQuery: searchQuery)
    navigationController.pushViewController(vc, animated: true)
  }

  func showRestaurantCardSelection(viewController: FoodPreferencesViewController, searchQuery: SearchQuery) {
    let vc = instantiateRestaurantCardSelection(searchQuery: searchQuery)
    navigationController.pushViewController(vc, animated: true)
  }

  func restaurantCardSelection(_ viewController: RestaurantCardSelectionViewController, failedWith error: GameError) {
    let vc = instantiateNoRestaurantError()
    navigationController.present(vc, animated: true) {
      self.navigationController.popToRootViewController(animated: false)
    }
  }

  func noRestaurantViewControllerFinished(_ viewController: NoRestaurantFoundViewController) {
    viewController.dismiss(animated: true, completion: nil)
  }

  func goBack() {
    _ = navigationController.popViewController(animated: true)
  }

  func close() {
    _ = navigationController.popToRootViewController(animated: true)
  }
}
