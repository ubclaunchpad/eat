//
//  PriceRatingFilterScreen.swift
//  Eat
//
//  Created by Sarina Chen on 2018-02-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class PriceRatingFilterScreen: UIViewController {

  @IBOutlet weak var ratingHeaderLabel: UILabel!
  @IBOutlet weak var ratingSlider: UISlider!
  @IBOutlet weak var ratingLabel: UILabel!

  @IBOutlet weak var lowPriceButton: UIButton!
  @IBOutlet weak var mediumPriceButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
