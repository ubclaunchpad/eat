//
//  RestaurantPhoneCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantPhoneCell: UITableViewCell {
  @IBOutlet weak var callRestaurantLabel: UILabel!
  @IBOutlet weak var phoneNumber: UILabel!
  @IBOutlet weak var phoneIcon: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantPhoneCellViewModel) {
    callRestaurantLabel.text = viewModel.callRestaurantText
    phoneNumber.text = viewModel.restaurantPhoneNumber
  }

  private func applyStyling() {
    callRestaurantLabel.font = Font.body(size: 16)
    callRestaurantLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)
    phoneNumber.font = Font.body(size: 11)
    phoneNumber.textColor = #colorLiteral(red: 0.6156862745, green: 0.6196078431, blue: 0.7490196078, alpha: 1)
  }
}
