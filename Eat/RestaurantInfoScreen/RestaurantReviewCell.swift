//
//  RestaurantReviewCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantReviewCell: UITableViewCell {


  @IBOutlet weak var reviewerName: UILabel!
  @IBOutlet weak var reviewContent: UILabel!
  @IBOutlet weak var reviewerImage: UIImageView!
  @IBOutlet weak var ratingSquare1: UIImageView!
  @IBOutlet weak var ratingSquare2: UIImageView!
  @IBOutlet weak var ratingSquare3: UIImageView!
  @IBOutlet weak var ratingSquare4: UIImageView!
  @IBOutlet weak var ratingSquare5: UIImageView!
  var ratingSquares: [UIImageView] = []

  func configure(review: Review) {
    reviewerName.text = review.userName
    let trimmed = review.content.components(separatedBy: .newlines).joined()
    reviewContent.text = trimmed
    reviewerName.font = Font.body(size: 12)
    reviewerName.textColor = #colorLiteral(red: 0.3830927014, green: 0.3831023574, blue: 0.3830972314, alpha: 1)
    reviewContent.font = Font.body(size: 12)
    reviewerImage.layer.cornerRadius = 4
    if let url = URL(string: review.userImage) {
      reviewerImage.kf.setImage(with: url)
    }
    
    ratingSquares = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
    for i in 0 ..< Int(round(review.userRating)){
      ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
    }
  }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
