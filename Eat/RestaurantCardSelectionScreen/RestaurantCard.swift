//
//  RestaurantCard.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantCard : UIView {
//  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var ratingLabel: UILabel!
  
  var contentView : UIView!
  var viewModel: Restaurant?

  init(restaurant: Restaurant) {
    self.viewModel = restaurant
    super.init(frame: UIScreen.main.bounds)
    xibSetup()
    configure(forViewModel: viewModel)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

  private func configure(forViewModel viewModel: Restaurant?) {
    if let viewModel = viewModel {
      titleLabel.text = viewModel.name
      ratingLabel.text = String(viewModel.rating)
    }
  }

  func xibSetup() {
    contentView = loadViewFromNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(contentView)
  }

  func loadViewFromNib() -> UIView! {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    return view
  }

}
