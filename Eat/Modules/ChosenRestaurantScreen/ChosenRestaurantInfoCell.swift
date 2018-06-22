//
//  ChosenRestaurantInfoCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class ChosenRestaurantInfoCell: UITableViewCell {


  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var distance: UILabel!
  @IBOutlet weak var foodtype: UILabel!
  @IBOutlet weak var hoursofoperation: UILabel!
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
    title.font = Font.bold(size: 24)

    // set distance
    distance.text = String(format: "%.2f", restaurant.distance/1000) + "km"
    distance.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    distance.font = Font.regular(size: 14)

    // set foodtype
    foodtype.text = restaurant.foodType
    foodtype.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    foodtype.font = Font.regular(size: 12)

    // set hours
    if(!restaurant.status) {
      hoursofoperation.text = "Open Now"
      hoursofoperation.textColor = #colorLiteral(red: 0.1512300968, green: 0.6803299785, blue: 0.3782986999, alpha: 1)
    } else {
      hoursofoperation.text = "Closed"
      hoursofoperation.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    }
    hoursofoperation.font = Font.regular(size: 12)

    // set ReviewSize
    reviewSize.text = String(restaurant.reviewCount) + " " + "reviews"
    reviewSize.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    reviewSize.font = Font.regular(size: 12)

    // Set the ratings
    ratingSquares = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
    for i in 0 ..< Int(round(restaurant.rating)){
      ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")

    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

}
