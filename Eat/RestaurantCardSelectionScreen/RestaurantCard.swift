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
  @IBOutlet weak var openNowLabel: UILabel!
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
      // set hours
      if(!viewModel.status) {
        openNowLabel.text = "Open Now"
        openNowLabel.textColor = #colorLiteral(red: 0.1512300968, green: 0.6803299785, blue: 0.3782986999, alpha: 1)
      } else {
        openNowLabel.text = "Closed"
        openNowLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
      }
      setStyling()
      if let url = URL(string: viewModel.imageUrl) {
        imageView.kf.setImage(with: url)
      } else {
        imageView.image = #imageLiteral(resourceName: "default_restaurant_photo")
        imageView.layer.backgroundColor = #colorLiteral(red: 0.9134720564, green: 0.9174253345, blue: 0.9339053035, alpha: 1)
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
    titleLabel.font = Font.bold(size: 18)
    distanceLabel.textColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    distanceLabel.font = Font.regular(size: 15)
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
