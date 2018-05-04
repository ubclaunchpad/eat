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
  @IBOutlet weak var openNow: UILabel!
  @IBOutlet weak var reviewSize: UILabel!
  @IBOutlet weak var ratingSquare1: UIImageView!
  @IBOutlet weak var ratingSquare2: UIImageView!
  @IBOutlet weak var ratingSquare3: UIImageView!
  @IBOutlet weak var ratingSquare4: UIImageView!
  @IBOutlet weak var ratingSquare5: UIImageView!
  var ratingSquares: [UIImageView] = []


  func configure(restaurant: Restaurant) {
      // set Title
      title.text = restaurant.name
      title.font = Font.header(size: 18)

      // set distance
      distance.text = String(format: "%.2f", restaurant.distance/1000) + "km"
      distance.textColor = UIColor.gray
      distance.alpha = 0.9
      distance.font = Font.regular(size: 14)

      // set foodtype
      foodtype.text = restaurant.foodType
      foodtype.textColor = UIColor.gray
      foodtype.alpha = 0.9
      foodtype.font = Font.regular(size: 14)

      // set hours
      if(!restaurant.status) {
        openNow.text = "Open Now"
        openNow.textColor = #colorLiteral(red: 0.1512300968, green: 0.6803299785, blue: 0.3782986999, alpha: 1)
      } else {
        openNow.text = "Closed"
        openNow.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
      }
      openNow.font = Font.regular(size: 14)

      // set ReviewSize
      reviewSize.text = String(restaurant.reviewCount) + " Reviews"
      reviewSize.textColor = UIColor.gray
      reviewSize.alpha = 0.9
      reviewSize.font = Font.regular(size: 14)

      // set up button
      for i in 0 ..< Int(round(restaurant.rating)){
        ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
      }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        ratingSquares = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
        // Initialization code
    }

}
