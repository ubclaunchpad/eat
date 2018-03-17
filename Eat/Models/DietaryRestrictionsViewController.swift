//
//  DietaryRestrictionsViewController.swift
//  Eat
//
//  Created by Sepand on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class DietaryRestrictionsViewController: UIViewController {

  let ourColour = "F79C88"
  @IBOutlet weak var OtherPrefs: UITextField!
  @IBOutlet weak var QuestionText: UILabel!
  @IBOutlet weak var VeganButton: UIButton!
  @IBOutlet weak var None: UIButton!
  @IBOutlet weak var VegetarianButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view.
    OtherPrefs.font = Font.body(size: 18)
    QuestionText.font = Font.header(size: 18)
//    VeganButton.font = Font.header(size: 18)
//    VegetarianButton.font = Font.header(size: 18)
    // Vegan
    VeganButton.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    VeganButton.layer.cornerRadius = 8
    VeganButton.layer.borderWidth = 2
    VeganButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    // Vegetarian
    VegetarianButton.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    VegetarianButton.layer.cornerRadius = 8
    VegetarianButton.layer.borderWidth = 2
    VegetarianButton.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
    // None
    None.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1), for: .normal)
    None.layer.cornerRadius = 8
    None.layer.borderWidth = 2
    None.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.6117647059, blue: 0.5333333333, alpha: 1)
//    OtherPrefs.text = "Eg: Vietnamese, bubble tea..."
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
