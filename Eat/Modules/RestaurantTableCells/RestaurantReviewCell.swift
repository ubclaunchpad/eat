//
//  RestaurantReviewCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

final class RestaurantReviewCell: UITableViewCell {
  @IBOutlet weak var reviewerName: UILabel!
  @IBOutlet weak var reviewContent: UILabel!
  @IBOutlet weak var reviewerImage: UIImageView!
  @IBOutlet weak var ratingSquare1: UIImageView!
  @IBOutlet weak var ratingSquare2: UIImageView!
  @IBOutlet weak var ratingSquare3: UIImageView!
  @IBOutlet weak var ratingSquare4: UIImageView!
  @IBOutlet weak var ratingSquare5: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantReviewCellViewModel) {
    reviewerName.text = viewModel.userName
    reviewContent.text = viewModel.content.components(separatedBy: .newlines).joined()
    if let url = viewModel.userImageURL {
      reviewerImage.kf.setImage(with: url)
    }

    let ratingSquares: [UIImageView] = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
    for i in 0 ..< viewModel.rating {
      ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
    }
  }

  private func applyStyling() {
    reviewerName.font = Font.regular(size: 12)
    reviewerName.textColor = #colorLiteral(red: 0.3830927014, green: 0.3831023574, blue: 0.3830972314, alpha: 1)
    reviewContent.font = Font.regular(size: 12)
    reviewerImage.layer.cornerRadius = 4

    selectionStyle = .none
  }
}
