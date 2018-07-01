//
//  AppCoordinator.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
  fileprivate var currentCoordinator: Coordinator?

  fileprivate let dataManager: OnboardingDataManager = DataManager.default

  fileprivate let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    if dataManager.isFirstLaunch() {
      showOnboarding()
    } else {
      showContent()
    }
    window.makeKeyAndVisible()
  }
}

extension AppCoordinator {
  func showOnboarding() {
    let navigationController = UINavigationController()
    let onboardingCoordinator = OnboardingCoordinator(delegate: self, navigationController: navigationController, window: window)
    onboardingCoordinator.start()
    currentCoordinator = onboardingCoordinator
    window.rootViewController = navigationController
  }

  func showContent() {
    let navigationController = UINavigationController()
    let contentCoordinator = ContentCoordinator(delegate: self, navigationController: navigationController)
    contentCoordinator.start()
    currentCoordinator = contentCoordinator
    window.rootViewController = navigationController
  }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
  func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator, from viewController: UIViewController) {
    showContent()
  }
}

extension AppCoordinator: ContentCoordinatorDelegate {
  func contentCoordinatorDidFinish(_ coordinator: ContentCoordinator) {
    // Content should not finish
  }
}
