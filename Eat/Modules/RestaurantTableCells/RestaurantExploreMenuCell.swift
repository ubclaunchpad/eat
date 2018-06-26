//
//  ExploreMenuCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantExploreMenuCell: UITableViewCell {
  @IBOutlet weak var exploreLabel: UILabel!
  @IBOutlet weak var exploreIcon: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantExploreMenuCellViewModel) {
    exploreLabel.text = viewModel.exploreMenuText
  }

  private func applyStyling() {
    exploreLabel.font = Font.body(size: 16)
    exploreLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)
  }
}
