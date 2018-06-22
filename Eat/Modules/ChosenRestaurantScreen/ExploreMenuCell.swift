//
//  ExploreMenuCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-21.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class ExploreMenuCell: UITableViewCell {

  @IBOutlet weak var ExploreLabel: UILabel!
  @IBOutlet weak var exploreIcon: UIImageView!

  func configure(restaurant: Restaurant) {
    ExploreLabel.text = "Explore on Yelp"
    ExploreLabel.font = Font.body(size: 16)
    ExploreLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
