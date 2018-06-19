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

  fileprivate let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    showOnboarding()
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

  func showContent(from viewController: UIViewController) {
    let navigationController = UINavigationController()
    let contentCoordinator = ContentCoordinator(delegate: self, navigationController: navigationController, from: viewController)
    contentCoordinator.start()
    currentCoordinator = contentCoordinator
  }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
  func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator, from viewController: UIViewController) {
    showContent(from: viewController)
  }
}

extension AppCoordinator: ContentCoordinatorDelegate {
  func contentCoordinatorDidFinish(_ coordinator: ContentCoordinator) {
    // Content should not finish
  }
}
