//
//  ViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class EatingTimeViewController: UIViewController {
  @IBOutlet weak var Temp: UILabel!
  @IBOutlet weak var HeaderEatDate: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    Temp.font = Font.body(size: 18)
    HeaderEatDate.font = Font.header(size: 22)
    dateLabel.font = Font.body(size: 22)
    //
    dateLabel.text = "Now"
  }

  //: # Today's Date
  let thisTimeTomrrow = NSDate(timeIntervalSinceNow: 86400)
  let thisTimeYesterday = NSDate(timeIntervalSinceNow: -86400)


  @IBAction func datePickerChanged(_ sender: Any) {
    dateLabel.text = datePicker.date.toString()
  }

}

