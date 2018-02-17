//
//  ViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class EatingTimeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //label.font = Font.bold(size: fontSize)
  //label.font = Font.bold(size: fontSize)
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  //
  @IBAction func datePickerChanged(_ sender: Any) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.short
    dateFormatter.timeStyle = DateFormatter.Style.short

    let strDate = dateFormatter.string(from: datePicker.date)
    dateLabel.text = strDate
  }

}

