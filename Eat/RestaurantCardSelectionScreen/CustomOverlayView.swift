//
//  OverlayView.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "overlay_keep"
private let overlayLeftImageName = "overlay_skip"

class CustomOverlayView: OverlayView {

  @IBOutlet lazy var overlayImageView: UIImageView! = {
    [unowned self] in

    var imageView = UIImageView(frame: self.bounds)
    self.addSubview(imageView)

    return imageView
    }()

  override var overlayState: SwipeResultDirection? {
    didSet {
      switch overlayState {
      case .left? :
        overlayImageView.image = UIImage(named: overlayLeftImageName)
      case .right? :
        overlayImageView.image = UIImage(named: overlayRightImageName)
      default:
        overlayImageView.image = nil
      }
    }
  }


}
