//
//  NibView.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-16.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class NibView: UIView {

  var view: UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
}


private extension NibView {
  func xibSetup(){
    backgroundColor = UIColor.clear
    view = loadViewFromNib()
    view.frame = bounds
    addSubview(view)

    view.translatesAutoresizingMaskIntoConstraints = false
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[childView]|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: ["childView": view]))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[childView]|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: ["childView": view]))
  }

  private func loadViewFromNib<T: UIView>() -> T {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
      fatalError("Cannot instantiate a UIView from the nib for class \(type(of: self))")
    }
    return view
  }
}

//extension UIView {
//  func loadNib() -> UIView {
//    let bundle = Bundle(for: type(of: self))
//    let nibName = type(of: self).description().components(separatedBy: ".").last!
//    let nib = UINib(nibName: nibName, bundle: bundle)
//    return nib.instantiate(withOwner: self, options: nil).first as! UIView
//  }
//}












