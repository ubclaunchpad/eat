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
    let mapViewController = MapViewController(viewModel: viewModel)
    navigationController.viewControllers = [mapViewController]
    navigationController.setNavigationBarHidden(true, animated: false)
    fromViewController.present(navigationController, animated: true, completion: nil)
  }
}
