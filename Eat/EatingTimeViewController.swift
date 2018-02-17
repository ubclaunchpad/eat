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
    HeaderEatDate.font = Font.header(size: 18)
    dateLabel.font = Font.body(size: 20)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //label.font = Font.bold(size: fontSize)
  //label.font = Font.bold(size: fontSize)

  //
  @IBAction func datePickerChanged(_ sender: Any) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.full
    dateFormatter.timeStyle = DateFormatter.Style.full

    let strDate = dateFormatter.string(from: datePicker.date)
    dateLabel.text = strDate
  }

}

