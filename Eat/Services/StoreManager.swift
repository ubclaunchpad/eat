//
//  StoreManager.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-30.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import StoreKit

final class StoreManager {
  private struct Constants {
    static let timeDelay = 2.0
  }

  fileprivate let dataManager: StoreDataManager = DataManager()

  func requestUserReview() {
    // Get the current bundle version for the app
    let infoDictionaryKey = kCFBundleVersionKey as String
    guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
      else { fatalError("Expected to find a bundle version in the info dictionary") }

    let lastVersionPromptedForReview = dataManager.lastBuildVersion()

    if currentVersion != lastVersionPromptedForReview {
      let twoSecondsFromNow = DispatchTime.now() + Constants.timeDelay
      DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) { [weak self] in
        SKStoreReviewController.requestReview()
        self?.dataManager.setLastBuildVersion(currentVersion: currentVersion)
      }
    }
  }
}

