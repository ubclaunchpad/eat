//
//  EatUITests.swift
//  EatUITests
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import XCTest

class EatUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false

    app = XCUIApplication()

    self.addUIInterruptionMonitor(withDescription: "Location Permissions") { (alert) -> Bool in
      let allowLocation = alert.buttons["Allow"]
      if allowLocation.exists {
        allowLocation.tap()
        return true
      }
      XCTFail("Unexpected System Alert")
      return false
    }

    app.launchArguments.append("--skip-onboarding")
  }

  override func tearDown() {
    super.tearDown()
  }

  static var dateFormatter: DateFormatter {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "MMM d"
    return dateformatter
  }

  static var pastTime: String {
    let calendar = NSCalendar.current
    let newDate = calendar.date(byAdding: .day, value: -1, to: Date())!
    let month = calendar.component(.month, from: newDate)
    return EatUITests.dateFormatter.string(from: newDate)
  }

  static var futureTime: String {
    let calendar = NSCalendar.current
    let newDate = calendar.date(byAdding: .day, value: 1, to: Date())!
    let month = calendar.component(.month, from: newDate)
    return EatUITests.dateFormatter.string(from: newDate)
  }

  func testMap() {
    app.launch()
    app.tap()

    // Map View
    XCTAssertTrue(app.otherElements[Accessibility.mapView].exists)

    app.buttons[Accessibility.mapNext].tap()
  }

  func testPeopleCount() {
    app.launch()
    app.tap()

    // Map View
    app.buttons[Accessibility.mapNext].tap()

    // People Count
    let increaseButton = app.buttons[Accessibility.increaseButton]
    let decreaseButton = app.buttons[Accessibility.decreaseButton]

    for _ in 0...11 {
      increaseButton.tap()
    }

    XCTAssertEqual(app.staticTexts[Accessibility.countLabel].label, "10")

    for _ in 0...11 {
      decreaseButton.tap()
    }

    XCTAssertEqual(app.staticTexts[Accessibility.countLabel].label, "1")

    app.buttons[Accessibility.countNext].tap()
  }

  func testMealTime() {
    app.launch()
    app.tap()

    // Map View
    app.buttons[Accessibility.mapNext].tap()

    // People Count
    app.buttons[Accessibility.countNext].tap()

    // Meal Time
    app.textViews[Accessibility.mealTimeTextField].tap()
    XCTAssertTrue(app.datePickers[Accessibility.mealTimeDatePicker].exists)

    let datePickerWheel = app.datePickers[Accessibility.mealTimeDatePicker].pickerWheels.element(boundBy: 0)

    datePickerWheel.adjust(toPickerWheelValue: EatUITests.futureTime)

    XCTAssertNotEqual(app.textViews[Accessibility.mealTimeTextField].value as! String, "The restaurant should be open now")

    let toolbar = app.toolbars[Accessibility.mealTimeToolbar]
    toolbar.buttons[Accessibility.mealTimeToolbarNow].tap()

    XCTAssertEqual(app.textViews[Accessibility.mealTimeTextField].value as! String, "The restaurant should be open now")

    datePickerWheel.adjust(toPickerWheelValue: EatUITests.pastTime)

    XCTAssertEqual(app.textViews[Accessibility.mealTimeTextField].value as! String, "The restaurant should be open now")

    toolbar.buttons[Accessibility.mealTimeToolbarDone].tap()
    app.buttons[Accessibility.mealTimeNext].tap()
  }

  func testPreferences() {
    app.launch()
    app.tap()

    // Map View
    app.buttons[Accessibility.mapNext].tap()

    // People Count
    app.buttons[Accessibility.countNext].tap()

    // Meal Time
    app.buttons[Accessibility.mealTimeNext].tap()

    // Rating Price
    app.buttons[Accessibility.ratingPriceNext].tap()

    // Preference
    app.textFields[Accessibility.preferenceTextField].tap()

    let sampleText = "s"

    app.typeText(sampleText)
    XCTAssertEqual(app.textFields[Accessibility.preferenceTextField].value as! String, sampleText)
    app.keys["delete"].tap()

    print(app.textFields[Accessibility.preferenceTextField].placeholderValue!)
    XCTAssertEqual(app.textFields[Accessibility.preferenceTextField].placeholderValue!, "Eg: French, bubble tea")
    app.tap()
    app.buttons[Accessibility.preferenceFinish].tap()
  }

  func testRestaurantCards() {
    app.launch()
    app.tap()

    // Map View
    app.buttons[Accessibility.mapNext].tap()

    // People Count
    app.buttons[Accessibility.countNext].tap()

    // Meal Time
    app.buttons[Accessibility.mealTimeNext].tap()

    // Rating Price
    app.buttons[Accessibility.ratingPriceNext].tap()

    // Preference
    app.buttons[Accessibility.preferenceFinish].tap()

    // Restaurant Selection
    let restaurantCard = app.otherElements[Accessibility.restaurantCard + "0"]
    XCTAssertTrue(restaurantCard.waitForExistence(timeout: 5))

    XCTAssertTrue(app.staticTexts[Accessibility.restaurantCardName].exists)
    XCTAssertTrue(app.staticTexts[Accessibility.restaurantCardType].exists)
    XCTAssertTrue(app.staticTexts[Accessibility.restaurantCardDistance].exists)
    XCTAssertTrue(app.staticTexts[Accessibility.restaurantCardReview].exists)
    XCTAssertTrue(app.staticTexts[Accessibility.restaurantCardOpen].exists)

    restaurantCard.tap()

    let tablesQuery = app.tables
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoName].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoType].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoDistance].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoReview].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoOpen].exists)

    tablesQuery.staticTexts[Accessibility.restaurantInfoMenu].tap()
    XCTAssertTrue((app.otherElements["URL"].value as! String).contains("yelp.com"))
    app.buttons["Done"].tap()

    app.buttons[Accessibility.restaurantCardClose].tap()

    let keep = app.buttons[Accessibility.keepButton]
    let skip = app.buttons[Accessibility.skipButton]
    keep.tap()
    skip.tap()
    keep.tap()
    keep.tap()

    let header = app.staticTexts[Accessibility.chosenRestaurantHeader]
    XCTAssertTrue(header.waitForExistence(timeout: 5))
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoName].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoType].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoDistance].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoReview].exists)
    XCTAssertTrue(tablesQuery.staticTexts[Accessibility.restaurantInfoOpen].exists)

    tablesQuery.staticTexts[Accessibility.restaurantExploreMenu].tap()
    XCTAssertTrue((app.otherElements["URL"].value as! String).contains("yelp.com"))
    app.buttons["Done"].tap()

    XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["chosenRestaurantHeader"]/*[[".staticTexts[\"The group has chosen!\"]",".staticTexts[\"chosenRestaurantHeader\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()


  }
}
