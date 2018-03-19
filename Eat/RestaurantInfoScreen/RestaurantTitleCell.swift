//
//  RestaurantTitleCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import Foundation

class RestaurantTitleCell: UITableViewCell {


  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var distance: UILabel!
  @IBOutlet weak var foodtype: UILabel!
  @IBOutlet weak var hoursofoperation: UILabel!
  @IBOutlet weak var ReviewSize: UILabel!


  func configure(restaurant: Restaurant) {
      // set Title
      title.text = restaurant.name
      title.font = UIFont.boldSystemFont(ofSize: 24)

      // set distance
      distance.text = String(format: "%.2f", restaurant.distance/1000) + "km"
      distance.textColor = UIColor.gray
      distance.alpha = 0.9
      distance.font = UIFont.systemFont(ofSize: 18)

      // set foodtype
      foodtype.text = restaurant.foodType
      foodtype.textColor = UIColor.gray
      foodtype.alpha = 0.9
      foodtype.font = UIFont.systemFont(ofSize: 16)

      // set hours
      hoursofoperation.text = "Open until 11pm"
      hoursofoperation.textColor = UIColor.init(red: 0.40, green: 0.71, blue: 0.48, alpha: 1)
      hoursofoperation.font = UIFont.boldSystemFont(ofSize: 16)

      // set ReviewSize
      ReviewSize.text = String(restaurant.reviewCount) + " Reviews"
      ReviewSize.textColor = UIColor.gray
      ReviewSize.alpha = 0.9
      ReviewSize.font = UIFont.systemFont(ofSize: 16)

      // set up button

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
