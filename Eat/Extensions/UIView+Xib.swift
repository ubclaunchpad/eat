//
//  UIView+Xib.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-23.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

extension UIView {
  class func instanceFromNib<T: UIView>() -> T {
    if let nib = UINib(nibName: String(describing: T.self), bundle: nil)
      .instantiate(withOwner: nil, options: nil)[0] as? T {
      return nib
    }
    fatalError("Could not find assosciated view with nib name \(String(describing: T.self))")
  }
}
