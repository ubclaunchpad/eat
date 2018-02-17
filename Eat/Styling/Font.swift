//
//  Font.swift
//  Eat
//
//  Created by Milton Leung on 2018-02-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

internal struct Font {
    static func regular(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular) }
    static func medium(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium) }
    static func bold(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold) }
    static func semibold(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold) }
    }
}
