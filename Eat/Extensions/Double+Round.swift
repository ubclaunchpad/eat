//
//  Double+Round.swift
//  Eat
//
//  Created by Milton Leung on 2018-03-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

extension Double {
  func round(nearest: Double) -> Double {
    let n = 1/nearest
    let numberToRound = self * n
    return numberToRound.rounded() / n
  }
}
