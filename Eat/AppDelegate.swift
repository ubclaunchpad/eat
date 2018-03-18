//
//  AppDelegate.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import Onboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    // Initialize onboarding view controller
    var onboardingVC = OnboardingViewController()

    // Create slides
    let firstPage = OnboardingContentViewController.content(withTitle: "Set your location and food preferences", body: "", image: UIImage(named: "OnboardingFirstScreen")?.resize(maxWidthHeight: 277), buttonText: nil, action: nil)

    // Setup first page
    firstPage.topPadding = 277
    firstPage.titleLabel.textColor = UIColor(red: 0.42, green: 0.44, blue: 0.6, alpha: 1)
    firstPage.titleLabel.font = UIFont(name: "CircularStd-Medium", size: 16)
    firstPage.underIconPadding = 32
    firstPage.underPageControlPadding = 96

    let secondPage = OnboardingContentViewController.content(withTitle: "Pass the phone around to let your friends vote on nearby restaurants", body: "", image: UIImage(named: "OnboardingSecondScreen")?.resize(maxWidthHeight: 277), buttonText: nil, action: nil)

    // Setup second page
    secondPage.topPadding = 277
    secondPage.titleLabel.textColor = UIColor(red: 0.42, green: 0.44, blue: 0.6, alpha: 1)
    secondPage.titleLabel.font = UIFont(name: "CircularStd-Medium", size: 16)
    secondPage.underIconPadding = 32
    secondPage.underPageControlPadding = 96

    let thirdPage = OnboardingContentViewController.content(withTitle: "Eat.", body: "", image: UIImage(named: "OnboardingThirdScreen")?.resize(maxWidthHeight: 277), buttonText: "EAT NOW", action: nil)

    // Setup third page
    thirdPage.topPadding = 277
    thirdPage.titleLabel.textColor = UIColor(red: 0.42, green: 0.44, blue: 0.6, alpha: 1)
    thirdPage.titleLabel.font = UIFont(name: "CircularStd-Medium", size: 16)
    thirdPage.underIconPadding = 32
    thirdPage.actionButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    thirdPage.actionButton.backgroundColor = UIColor(red: 0.36, green: 0.41, blue: 1, alpha: 1)
    thirdPage.underPageControlPadding = 0

    // Define onboarding view controller properties
    onboardingVC = OnboardingViewController.onboard(withBackgroundImage: UIImage(named: "OnboardingBackground"), contents: [firstPage, secondPage, thirdPage])
    onboardingVC.shouldFadeTransitions = true
    onboardingVC.shouldMaskBackground = false
    onboardingVC.shouldBlurBackground = false
    onboardingVC.fadePageControlOnLastPage = true
    onboardingVC.pageControl.pageIndicatorTintColor = UIColor(red: 0.92, green: 0.9, blue: 0.95, alpha: 1)
    onboardingVC.pageControl.currentPageIndicatorTintColor = UIColor(red: 1.00, green: 0.76, blue: 0.47, alpha: 1)
    onboardingVC.allowSkipping = false
    onboardingVC.underPageControlPadding = 96

    self.window?.rootViewController = onboardingVC

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  


}

extension UIImage {

  func resize(maxWidthHeight : Double)-> UIImage? {

    let actualHeight = Double(size.height)
    let actualWidth = Double(size.width)
    var maxWidth = 0.0
    var maxHeight = 0.0

    if actualWidth > actualHeight {
      maxWidth = maxWidthHeight
      let per = (100.0 * maxWidthHeight / actualWidth)
      maxHeight = (actualHeight * per) / 100.0
    }else{
      maxHeight = maxWidthHeight
      let per = (100.0 * maxWidthHeight / actualHeight)
      maxWidth = (actualWidth * per) / 100.0
    }

    let hasAlpha = true
    let scale: CGFloat = 0.0

    UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
    self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))

    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    return scaledImage
  }

}

