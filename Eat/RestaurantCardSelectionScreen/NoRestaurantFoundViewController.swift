//
//  NoRestaurantFoundViewController.swift
//  Eat
//
//  Created by Sarina Chen on 2018-04-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class NoRestaurantFoundViewController: UIViewController {

  @IBOutlet weak var noRestaurantFoundImage: UIImageView!
  @IBOutlet weak var noRestaurantFoundLabel: UILabel!
  @IBOutlet weak var adjustPreferenceButton: UIButton!

  static func viewController() -> NoRestaurantFoundViewController {
    let storyboard = UIStoryboard(name: "RestaurantCardSelectionStoryboard", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "NoRestaurantFoundViewController") as? NoRestaurantFoundViewController
      else { fatalError() }
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setStyling()
    }

  @IBAction func adjustPreferenceButtonPressed(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }

  private func setStyling(){
    view.layer.backgroundColor = #colorLiteral(red: 0.9685223699, green: 0.9686879516, blue: 0.9685119987, alpha: 1)
    noRestaurantFoundLabel.font = Font.body(size: 16)
    noRestaurantFoundLabel.textColor = #colorLiteral(red: 0.4183886945, green: 0.4357136786, blue: 0.601531148, alpha: 1)

    let adjustPreferenceButtonTitle = NSMutableAttributedString(string: "ADJUST PREFERENCES")
    adjustPreferenceButtonTitle.addAttributes([NSAttributedStringKey.kern: CGFloat(2), NSAttributedStringKey.foregroundColor : UIColor.white], range: NSRange(location: 0, length: adjustPreferenceButtonTitle.length))
    adjustPreferenceButton.setAttributedTitle(adjustPreferenceButtonTitle, for: .normal)
    adjustPreferenceButton.titleLabel?.font = Font.boldButton(size: 17)
    adjustPreferenceButton.backgroundColor = #colorLiteral(red: 0.362785995, green: 0.4117482901, blue: 0.9952250123, alpha: 1)
    adjustPreferenceButton.layer.cornerRadius = 15
    adjustPreferenceButton.layer.shadowColor = #colorLiteral(red: 0.2009466769, green: 0.2274558959, blue: 0.5609335343, alpha: 1)
    adjustPreferenceButton.layer.shadowOffset = CGSize(width: 2, height: 10)
    adjustPreferenceButton.layer.masksToBounds = false
    adjustPreferenceButton.layer.shadowRadius = 5.0
    adjustPreferenceButton.layer.shadowOpacity = 0.25
  }

}
