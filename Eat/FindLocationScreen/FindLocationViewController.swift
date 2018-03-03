//
//  FindLocationViewController.swift
//  Eat
//
//  Created by Kelvin Chan on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit
import SearchTextField

class FindLocationViewController : UIViewController {
    
    @IBOutlet weak var addressField: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        guard addressField != nil else {
//            print("no address field")
//        }
        
        addressField.filterStrings(["hi", "hello", "hello there"])
    }
}
