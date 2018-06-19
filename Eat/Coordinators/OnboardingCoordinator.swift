//
//  OnboardingCoordinator.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

protocol OnboardingCoordinatorDelegate: class {
  func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator, from viewController: UIViewController)
}

final class OnboardingCoordinator: Coordinator {
  fileprivate let navigationController: UINavigationController
  fileprivate let delegate: OnboardingCoordinatorDelegate
  fileprivate let window: UIWindow

  init(delegate: OnboardingCoordinatorDelegate,
       navigationController: UINavigationController,
       window: UIWindow) {
    self.delegate = delegate
    self.window = window
    self.navigationController = navigationController
    navigationController.setNavigationBarHidden(true, animated: false)
  }

  func start() {
    let onboarding = Onboarding(window: window)
    onboarding.onFinishTapped = {
      self.delegate.onboardingCoordinatorDidFinish(self, from: self.navigationController)
    }
    navigationController.viewControllers = [onboarding.viewController()]
  }
}

