//
//  AppDelegate.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    if CommandLine.arguments.contains("--onboarding") {
      DataManager.default.setFirstLaunch(value: false)
    } else if CommandLine.arguments.contains("--skip-onboarding") {
      DataManager.default.setFirstLaunch(value: true)
    }

    let window = UIWindow()
    let coordinator = AppCoordinator(window: window)
    coordinator.start()
    self.window = window

    return true
  }
}

