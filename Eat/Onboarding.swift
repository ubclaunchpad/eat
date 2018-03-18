//
//  Onboarding.swift
//  Eat
//
//  Created by Milton Leung on 2018-03-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit

class Onboarding {
  let height = UIScreen.main.bounds.height
  let width = UIScreen.main.bounds.width

  func viewController(window: UIWindow?) -> OnboardingViewController {
    var onboardingVC = OnboardingViewController()

    let safeArea = window?.safeAreaInsets

    // Create slides
    let firstPage = OnboardingContentViewController.content(withTitle: "Set your location and food \n preferences", body: "", image: onboardingImageFit(image: #imageLiteral(resourceName: "OnboardingFirstScreen")), buttonText: nil, action: nil)
    applyStyling(to: firstPage)

    let secondPage = OnboardingContentViewController.content(withTitle: "Pass the phone around to let your \n friends vote on nearby restaurants", body: "", image: onboardingImageFit(image: #imageLiteral(resourceName: "OnboardingSecondScreen")), buttonText: nil, action: nil)
    applyStyling(to: secondPage)

    let thirdPage = OnboardingContentViewController.content(withTitle: "Eat.", body: "", image: onboardingImageFit(image: #imageLiteral(resourceName: "OnboardingThirdScreen")), buttonText: "EAT NOW") { _ in
      // YONNI change this to the map screen
      let vc = PeopleCountViewController.viewController(searchQuery: SearchQuery())
      onboardingVC.present(vc, animated: true, completion: nil)
    }

    applyStyling(to: thirdPage)

    thirdPage.actionButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    thirdPage.actionButton.titleLabel?.font = Font.onboarding(size: 17)

    let actionText = NSMutableAttributedString(string: "EAT NOW")
    actionText.addAttribute(NSAttributedStringKey.kern, value: CGFloat(2), range: NSRange(location: 0, length: actionText.length))

    thirdPage.actionButton.titleLabel?.attributedText = actionText
    thirdPage.actionButton.backgroundColor = UIColor(red: 0.36, green: 0.41, blue: 1, alpha: 1)
    thirdPage.actionButtonBottomMargin = 10 + (safeArea?.bottom ?? 0)
    thirdPage.actionButtonHorizontalMargin = 10 + (safeArea?.left ?? 0)
    thirdPage.actionButtonCornerRadius = 12

    // Define onboarding view controller properties
    onboardingVC = OnboardingViewController.onboard(withBackgroundImage: UIImage(color: #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)), contents: [firstPage, secondPage, thirdPage])
    onboardingVC.shouldFadeTransitions = true
    onboardingVC.shouldMaskBackground = false
    onboardingVC.shouldBlurBackground = false
    onboardingVC.fadePageControlOnLastPage = false
    onboardingVC.pageControl.pageIndicatorTintColor = UIColor(red: 0.92, green: 0.9, blue: 0.95, alpha: 1)
    onboardingVC.pageControl.currentPageIndicatorTintColor = UIColor(red: 1.00, green: 0.76, blue: 0.47, alpha: 1)
    onboardingVC.allowSkipping = false
    underPageControlPadding(viewController: onboardingVC)

    return onboardingVC
  }

  private func applyStyling(to viewController: OnboardingContentViewController) {
    switch UIScreen.main.nativeBounds.height {
    case 1136: // iPhone SE
      viewController.topPadding = 0.22 * height
      break
    case 1334: // iPhone 8
      viewController.topPadding = 0.225 * height
      break
    case 2208: // iPhone 8 Plus
      viewController.topPadding = 0.26 * height
      break
    case 2436: // iPhone X
      viewController.topPadding = 0.28 * height
      break
    default:
      viewController.topPadding = 0.22 * height
      viewController.underPageControlPadding = 0.15 * height
    }

    viewController.titleLabel.textColor = UIColor(red: 0.42, green: 0.44, blue: 0.6, alpha: 1)
    viewController.titleLabel.font = Font.onboarding(size: 16)
    viewController.underIconPadding = 32
  }

  private func onboardingImageFit(image: UIImage) -> UIImage {
    switch UIScreen.main.nativeBounds.height {
    case 1136: // iPhone SE
      return image.resize(maxWidthHeight: 240) ?? image
    default:
      return image
    }
  }

  private func underPageControlPadding(viewController: OnboardingViewController) {
    switch UIScreen.main.nativeBounds.height {
    case 1136: // iPhone SE
      viewController.underPageControlPadding = 0.14 * height
      break
    case 1334: // iPhone 8
      viewController.underPageControlPadding = 0.13 * height
      break
    case 2208: // iPhone 8 Plus
      viewController.underPageControlPadding = 0.17 * height
      break
    case 2436: // iPhone X
      viewController.underPageControlPadding = 0.17 * height
      break
    default:
      viewController.underPageControlPadding = 0.15 * height
    }
  }
}

