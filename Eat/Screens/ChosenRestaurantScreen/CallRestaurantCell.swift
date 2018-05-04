//
//  CallRestaurantCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-21.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class CallRestaurantCell: UITableViewCell {


  @IBOutlet weak var callRestaurantLabel: UILabel!
  @IBOutlet weak var phoneNumber: UILabel!
  @IBOutlet weak var phoneIcon: UIImageView!

  func configure(restaurant: Restaurant) {
    callRestaurantLabel.text = "Call restaurant"
    callRestaurantLabel.font = Font.body(size: 16)
    callRestaurantLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)
    phoneNumber.text = restaurant.phone
    phoneNumber.font = Font.body(size: 11)
    phoneNumber.textColor = #colorLiteral(red: 0.6156862745, green: 0.6196078431, blue: 0.7490196078, alpha: 1)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
