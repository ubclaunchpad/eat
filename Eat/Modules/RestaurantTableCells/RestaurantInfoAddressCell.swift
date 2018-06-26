//
//  RestaurantInfoAddressCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantInfoAddressCell: UITableViewCell {
  @IBOutlet weak var restaurantAddressLabel: UILabel!
  @IBOutlet weak var addressImage: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantInfoAddressCellViewModel) {
    restaurantAddressLabel.text = viewModel.restaurantAddress
  }

  private func applyStyling() {
    restaurantAddressLabel.font = Font.regular(size: 12)
    restaurantAddressLabel.textColor = #colorLiteral(red: 0.4991080165, green: 0.4995048642, blue: 0.4991694689, alpha: 1)

    selectionStyle = .none
  }
}
