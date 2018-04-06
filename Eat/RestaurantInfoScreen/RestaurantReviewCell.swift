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
    reviewContent.text = review.content
    reviewerImage.layer.cornerRadius = 5
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
