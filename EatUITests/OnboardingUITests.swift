//
//  OnboardingUITests.swift
//  EatUITests
//
//  Created by Milton Leung on 2018-06-26.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest
@testable import Eat

class OnboardingUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false

    app = XCUIApplication()

    app.launchArguments.append("--onboarding")
  }

  override func tearDown() {
    super.tearDown()
  }

  func testOnboardingFlow() {
    app.launch()

    XCTAssertTrue(app.otherElements[Accessibility.onboarding].exists)

    app.swipeLeft()
    app.swipeLeft()
    app.buttons[Accessibility.onboardingButton].tap()

    XCTAssertFalse(app.otherElements[Accessibility.onboarding].exists)
  }
}
