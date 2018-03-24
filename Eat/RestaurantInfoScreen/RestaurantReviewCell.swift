//
//  RestaurantReviewCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-10.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantReviewCell: UITableViewCell {


  @IBOutlet weak var ReviewerName: UILabel!
  @IBOutlet weak var Review: UILabel!
  @IBOutlet weak var reviewerImage: UIImageView!
  @IBOutlet weak var ratingSquare1: UIImageView!
  @IBOutlet weak var ratingSquare2: UIImageView!
  @IBOutlet weak var ratingSquare3: UIImageView!
  @IBOutlet weak var ratingSquare4: UIImageView!
  @IBOutlet weak var ratingSquare5: UIImageView!
  var ratingSquares: [UIImageView] = []

  func configure(review: Review) {
    ReviewerName.text = review.userName
    Review.text = review.content
    if let url = URL(string: review.userImage), let data = try? Data(contentsOf: url) {
      reviewerImage.image = UIImage(data: data)
    }
    ratingSquares = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
    for i in 0 ..< Int(round(review.userRating)){
      ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
    }

  }

    override func awakeFromNib() {
        super.awakeFromNib()
        reviewerImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
