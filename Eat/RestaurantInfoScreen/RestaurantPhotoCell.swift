//
//  RestaurantPhotoCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-16.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantPhotoCell: UITableViewCell {

  @IBOutlet weak var restaurantImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func configure(imageUrl: String) {
    if let url = URL(string: imageUrl) {
      restaurantImageView.kf.setImage(with: url)
    } else {
      restaurantImageView.image = #imageLiteral(resourceName: "default_restaurant_photo")
      restaurantImageView.layer.backgroundColor = #colorLiteral(red: 0.9134720564, green: 0.9174253345, blue: 0.9339053035, alpha: 1)
    }
  }

}
