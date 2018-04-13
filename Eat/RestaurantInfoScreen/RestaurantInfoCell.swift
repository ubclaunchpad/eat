//
//  RestaurantInfoCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantInfoCell: UITableViewCell {

  @IBOutlet weak var buttonImage: UIImageView!
  @IBOutlet weak var yelpLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        yelpLabel.font = Font.boldButton(size: 12)
        yelpLabel.textColor = #colorLiteral(red: 0.4415612221, green: 0.4858411551, blue: 0.9966537356, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
