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

  func configure() {
      // set Title
      title.text = "JamJar"
      title.font = UIFont.systemFont(ofSize: 20)

      // set distance
      distance.text = "0.7km"
      distance.textColor = UIColor.gray
      distance.alpha = 0.5
      distance.font = UIFont.systemFont(ofSize: 14)

      // set foodtype
      foodtype.text = "Lebanese"
      foodtype.textColor = UIColor.gray
      foodtype.alpha = 0.5
      foodtype.font = UIFont.systemFont(ofSize: 14)

      // set hours
      hoursofoperation.text = "Open until 11pm"
      hoursofoperation.textColor = UIColor.green
      hoursofoperation.font = UIFont.systemFont(ofSize: 14)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
