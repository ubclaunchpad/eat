//
//  Font.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

internal struct Font {
  static func header(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Medium", size: size)!
  }
  static func body(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Medium", size: size)!
  }
  static func formNavigation(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Book", size: size)!
  }
  static func button(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Book", size: size)!
  }
  static func boldButton(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Medium", size: size)!
  }
  static func formInput(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Book", size: size)!
  }
  static func onboarding(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Book", size: size)!
  }
  static func onboardingAction(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Bold", size: size)!
  }
  static func navigationHeaders(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Book", size: size)!
  }

  static func bold(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Bold", size: size)!
  }
  static func regular(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Book", size: size)!
  }
  static func medium(size: CGFloat) -> UIFont {
    return UIFont(name: "CircularStd-Medium", size: size)!
  }
}
