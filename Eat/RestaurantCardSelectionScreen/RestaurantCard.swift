//
//  RestaurantCard.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantCard : UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!

//  class func instanceFromNib() -> UIView {
//    return UINib(nibName: "RestaurantCard.xib", bundle: nil).instantiate(withOwner: "RestaurantCard", options: nil)[0] as! UIView
//  }

  var viewModel: Restaurant?

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(forViewModel: viewModel)
  }

  private func configure(forViewModel viewModel: Restaurant?) {
    if let viewModel = viewModel {
      titleLabel.text = viewModel.name

    }
  }

}
