//
//  Font.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

internal struct Font {
    static func header(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium) }
    static func body(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular) }
}
