//
//  ViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let yelpApiManager = YelpAPIManager.init()
    let dataManager = DataManager.init(yelpAPIManager: yelpApiManager)
    let query = SearchQuery(latitude: 2, longitude: 2, radius: 2, limit: 5, price: "$", vegetarian: false)
    dataManager.fetchRestaurants(with: query)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

