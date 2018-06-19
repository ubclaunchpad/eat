//
//  String+Localization.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation

extension String {
  func localize(with comment: String = "") -> String {
    return NSLocalizedString(self, comment: comment)
  }
}
