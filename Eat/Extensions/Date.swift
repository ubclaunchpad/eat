//
//  Date.swift
//  Eat
//
//  Created by Sepand on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

extension Date {
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E MMM d 'at' h:mm a"
    return dateFormatter.string(from: self)
  }
}
