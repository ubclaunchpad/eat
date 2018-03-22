//
//  RestaurantInfoCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantInfoCell: UITableViewCell {

  @IBOutlet weak var MenuButton: UIButton!
  @IBOutlet weak var buttonImage: UIImageView!
  

  override func awakeFromNib() {
        super.awakeFromNib()
        buttonImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
