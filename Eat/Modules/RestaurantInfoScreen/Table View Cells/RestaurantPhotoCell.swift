//
//  RestaurantPhotoCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantPhotoCell: UITableViewCell {
  @IBOutlet weak var restaurantImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
    separatorInset = UIEdgeInsets(top: 0, left: bounds.size.width, bottom: 0, right: 0)
  }

  func configure(with viewModel: RestaurantPhotoCellViewModel) {
    if let imageURL = viewModel.restaurantImageURL {
      restaurantImageView.kf.setImage(with: imageURL)
    } else {
      restaurantImageView.image = #imageLiteral(resourceName: "default_restaurant_photo")
      restaurantImageView.layer.backgroundColor = #colorLiteral(red: 0.9134720564, green: 0.9174253345, blue: 0.9339053035, alpha: 1)
    }
  }
}
