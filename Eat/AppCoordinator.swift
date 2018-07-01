//
//  AppCoordinator.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

final class AppCoordinator: Coordinator {
  fileprivate var currentCoordinator: Coordinator?

  fileprivate let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }

  func start() {

    window.makeKeyAndVisible()
  }
}

extension AppCoordinator {
  func showOnboarding() {
    
  }
}
