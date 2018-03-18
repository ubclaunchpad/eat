//
//  EatSlider.swift
//  Eat
//
//  Created by Milton Leung on 2018-03-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class EatSlider: UISlider {
  override func trackRect(forBounds bounds: CGRect) -> CGRect {
    var newBounds = super.trackRect(forBounds: bounds)
    newBounds.size.height = 4
    return newBounds
  }
}
