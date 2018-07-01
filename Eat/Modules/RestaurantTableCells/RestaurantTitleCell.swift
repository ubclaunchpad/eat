//
//  RestaurantTitleCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantTitleCell: UITableViewCell {
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

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantTitleCellViewModel) {
    title.text = viewModel.restaurantName
    foodtype.text = viewModel.restaurantType
    distance.text = viewModel.distance
    reviewSize.text = viewModel.numberOfReviews
    openNow.text = viewModel.restaurantOpen
    openNow.textColor = viewModel.restaurantOpenTextColor

    let ratingSquares: [UIImageView] = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
    for i in 0 ..< viewModel.restaurantRating {
      ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
    }

    selectionStyle = .none
  }

  private func applyStyling() {
    title.font = Font.bold(size: 18)
    distance.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    distance.font = Font.regular(size: 14)
    foodtype.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    foodtype.font = Font.regular(size: 14)
    openNow.font = Font.regular(size: 14)
    reviewSize.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    reviewSize.font = Font.regular(size: 14)

    title.accessibilityIdentifier = Accessibility.restaurantInfoName
    foodtype.accessibilityIdentifier = Accessibility.restaurantInfoType
    distance.accessibilityIdentifier = Accessibility.restaurantInfoDistance
    reviewSize.accessibilityIdentifier = Accessibility.restaurantInfoReview
    openNow.accessibilityIdentifier = Accessibility.restaurantInfoOpen
  }
}
