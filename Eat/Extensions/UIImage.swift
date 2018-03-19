//
//  UIImageColor.swift
//  Eat
//
//  Created by Milton Leung on 2018-03-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }


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
