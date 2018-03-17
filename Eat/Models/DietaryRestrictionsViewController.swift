//
//  DietaryRestrictionsViewController.swift
//  Eat
//
//  Created by Sepand on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class DietaryRestrictionsViewController: UIViewController {

  @IBOutlet weak var OtherPrefs: UITextField!

  @IBOutlet weak var QuestionText: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view.
    OtherPrefs.font = Font.body(size: 18)
    QuestionText.font = Font.header(size: 18)
    QuestionText.font = Font.header(size: 18)

    OtherPrefs.text = "Eg: Vietnamese, bubble tea..."
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
