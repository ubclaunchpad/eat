//
//  RestaurantCard.swift
//  Eat
//
//  Created by Sarina Chen on 2018-03-14.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class RestaurantCard : UIView {
//  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var reviewLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var ratingSquare1: UIImageView!
  @IBOutlet weak var ratingSquare2: UIImageView!
  @IBOutlet weak var ratingSquare3: UIImageView!
  @IBOutlet weak var ratingSquare4: UIImageView!
  @IBOutlet weak var ratingSquare5: UIImageView!
  @IBOutlet weak var moreInfoLabel: UILabel!

  var contentView : UIView!
  var viewModel: Restaurant?
  var ratingSquares: [UIImageView] = []

  init(restaurant: Restaurant) {
    self.viewModel = restaurant
    super.init(frame: UIScreen.main.bounds)
    xibSetup()
    configure(forViewModel: viewModel)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }


  private func configure(forViewModel viewModel: Restaurant?) {
    if let viewModel = viewModel {
      titleLabel.text = viewModel.name
      typeLabel.text = viewModel.foodType
      distanceLabel.text = String(format: "%.2f", viewModel.distance/1000) + "km"
      reviewLabel.text = String(viewModel.reviewCount) + " Reviews"
      phoneLabel.text = viewModel.phone
      setStyling()
      if let url = URL(string: viewModel.imageUrl), let data = try? Data(contentsOf: url) {
        imageView.image = UIImage(data: data)
      } else {
        imageView.image = #imageLiteral(resourceName: "default_restaurant_photo")
      }
      ratingSquares = [ratingSquare1, ratingSquare2, ratingSquare3, ratingSquare4, ratingSquare5]
      for i in 0 ..< Int(round(viewModel.rating)){
        ratingSquares[i].image = #imageLiteral(resourceName: "FilledRatingSquare")
      }
    }
  }

  func xibSetup() {
    contentView = loadViewFromNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(contentView)
  }

  func loadViewFromNib() -> UIView! {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    return view
  }

  private func setStyling(){
    titleLabel.font = Font.header(size: 24)
    distanceLabel.textColor = UIColor.gray
    distanceLabel.alpha = 0.9
    distanceLabel.font = Font.body(size: 16)
    typeLabel.textColor = UIColor.gray
    typeLabel.alpha = 0.9
    typeLabel.font = Font.body(size: 14)
    phoneLabel.textColor = #colorLiteral(red: 0.1527305841, green: 0.6796044707, blue: 0.3771348, alpha: 1)
    phoneLabel.font = Font.body(size: 14)
    reviewLabel.textColor = UIColor.gray
    reviewLabel.alpha = 0.9
    reviewLabel.font = Font.body(size: 14)
    moreInfoLabel.font = Font.boldButton(size: 16)

    layer.shadowColor = #colorLiteral(red: 0.6151413766, green: 0.6227521808, blue: 0.6790529822, alpha: 1)
    layer.shadowOffset = CGSize(width: 7, height: 7)
    layer.masksToBounds = false
    layer.shadowRadius = 15.0
    layer.shadowOpacity = 0.7
  }
}
