//
//  RestaurantReviewCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantReviewCell: UITableViewCell {


  @IBOutlet weak var ReviewerName: UILabel!
  @IBOutlet weak var Review: UILabel!

  func configure(restaurant: Restaurant) {
    ReviewerName.text = "Gina"

    // Set Review
    Review.text = "It was Great!"
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
