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
      ExploreLabel.font = UIFont.systemFont(ofSize: 16)
      ExploreLabel.textColor = UIColor(red: 0.42, green: 0.44, blue: 0.6, alpha: 1)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
