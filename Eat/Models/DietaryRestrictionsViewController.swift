//
//  DietaryRestrictionsViewController.swift
//  Eat
//
//  Created by Sepand on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import ChameleonFramework

class DietaryRestrictionsViewController: UIViewController {

  @IBOutlet weak var OtherPrefs: UITextField!
  @IBOutlet weak var preferenceQuestion: UILabel!
  @IBOutlet weak var VeganButton: UIButton!
  @IBOutlet weak var None: UIButton!
  @IBOutlet weak var VegetarianButton: UIButton!
  @IBOutlet weak var restrictionQuestion: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view.
    OtherPrefs.font = Font.body(size: 18)
    OtherPrefs.textColor = #colorLiteral(red: 0.2235294118, green: 0, blue: 0.8196078431, alpha: 1)
    preferenceQuestion.font = Font.header(size: 13)
    preferenceQuestion.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    restrictionQuestion.font = Font.header(size: 13)
    restrictionQuestion.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    // Vegan
    VeganButton.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    VeganButton.layer.cornerRadius = 8
    VeganButton.layer.borderWidth = 2
    VeganButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    VeganButton.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 20) //NEEDS TO BE CORRECTED
    VeganButton.setTitle("Vegan", for: .normal)
    VeganButton.backgroundColor = [#colorLiteral(red: 1, green: 0.7647058824, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)]
    view.backgroundColor = FlatGreen()
    // Vegetarian
    VegetarianButton.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    VegetarianButton.layer.cornerRadius = 8
    VegetarianButton.layer.borderWidth = 2
    VegetarianButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    VegetarianButton.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 20) //NEEDS TO BE CORRECTED
    VegetarianButton.setTitle("Vegetarian", for: .normal)
    // None
    None.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    None.layer.cornerRadius = 8
    None.layer.borderWidth = 2
    None.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    None.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 20) //NEEDS TO BE CORRECTED
    None.setTitle("None", for: .normal)
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
