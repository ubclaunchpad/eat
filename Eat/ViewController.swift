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
    let query = SearchQuery(latitude: 49.246292, longitude: -123.116226, radius: 1000, limit: 5, price: 3, vegetarian: false)
    let result = dataManager.fetchRestaurants(with: query)
    print("Got result in View Controller")
    result.andThen { result in
      switch result {
      case .success(let val):
        print(val)
      case .failure(_):
        print("No Restaurants returned")
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

