//
//  RestaurantInfoMenuCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantInfoMenuCell: UITableViewCell {
  @IBOutlet weak var buttonImage: UIImageView!
  @IBOutlet weak var yelpLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantInfoMenuCellViewModel) {
    yelpLabel.text = viewModel.exploreYelpText
  }

  func applyStyling() {
    yelpLabel.font = Font.regular(size: 12)
    yelpLabel.textColor = #colorLiteral(red: 0.4415612221, green: 0.4858411551, blue: 0.9966537356, alpha: 1)
  }
}
