//
//  RestaurantInfoAddressCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-12.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantInfoAddressCell: UITableViewCell {

  @IBOutlet weak var RestaurantAddress: UILabel!

  func configure() {
    RestaurantAddress.text = "6035 University Blvd, Vancouver, BC"
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
