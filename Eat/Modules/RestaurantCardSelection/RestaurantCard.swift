//
//  RestaurantCard.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantCard : UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var reviewLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var openNowLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var ratingSquare1: UIImageView!
  @IBOutlet weak var ratingSquare2: UIImageView!
  @IBOutlet weak var ratingSquare3: UIImageView!
  @IBOutlet weak var ratingSquare4: UIImageView!
  @IBOutlet weak var ratingSquare5: UIImageView!
  @IBOutlet weak var moreInfoLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantCardViewModel) {
    titleLabel.text = viewModel.restaurantName
    typeLabel.text = viewModel.restaurantType
    distanceLabel.text = viewModel.distance
    reviewLabel.text = viewModel.numberOfReviews
    openNowLabel.text = viewModel.restaurantOpen
    openNowLabel.textColor = viewModel.restaurantOpenTextColor

    if let imageURL = viewModel.restaurantImageURL {
      imageView.kf.setImage(with: imageURL)
    } else {
      imageView.image = #imageLiteral(resourceName: "default_restaurant_photo")
      imageView.layer.backgroundColor = #colorLiteral(red: 0.9134720564, green: 0.9174253345, blue: 0.9339053035, alpha: 1)
    }

    let ratingSquares: [UIImageView] = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
    for i in 0 ..< viewModel.restaurantRating {
      ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
    }
  }

  private func applyStyling() {
    titleLabel.font = Font.bold(size: 18)
    distanceLabel.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    distanceLabel.font = Font.regular(size: 14)
    typeLabel.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    typeLabel.font = Font.regular(size: 14)
    openNowLabel.font = Font.regular(size: 14)
    reviewLabel.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    reviewLabel.font = Font.regular(size: 14)
    moreInfoLabel.font = Font.regular(size: 14)
    moreInfoLabel.textColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)

    contentView.layer.cornerRadius = 15
    contentView.clipsToBounds = true
    layer.cornerRadius = 15
    layer.shadowColor = #colorLiteral(red: 0.6151413766, green: 0.6227521808, blue: 0.6790529822, alpha: 1)
    layer.shadowOffset = CGSize(width: 7, height: 7)
    layer.masksToBounds = false
    layer.shadowRadius = 15.0
    layer.shadowOpacity = 0.7
  }
}
