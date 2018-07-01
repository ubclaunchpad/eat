//
//  OverlayView.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import Koloda

final class CustomOverlayView: OverlayView {
  override var overlayState: SwipeResultDirection? {
    didSet {
      switch overlayState {
      case .left?:
        layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.35)
      case .right?:
        layer.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.8117647059, blue: 0.4352941176, alpha: 0.35)
      default:
        break
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func applyStyling() {
    layer.backgroundColor = UIColor.clear.cgColor
    layer.cornerRadius = 15
    layer.masksToBounds = true
  }
}
