//
//  RestaurantInfoAddressCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-12.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantInfoAddressCell: UITableViewCell {

  @IBOutlet weak var restaurantAddressLabel: UILabel!
  @IBOutlet weak var addressImage: UIImageView!

  func configure(restaurant: Restaurant) {
    restaurantAddressLabel.text = restaurant.address
    restaurantAddressLabel.font = Font.regular(size: 12)
    restaurantAddressLabel.textColor = #colorLiteral(red: 0.4991080165, green: 0.4995048642, blue: 0.4991694689, alpha: 1)
  }

  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
