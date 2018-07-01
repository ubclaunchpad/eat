//
//  NoRestaurantFoundViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-23.
//  Copyright © 2018 launchpad. All rights reserved.
//

protocol NoRestaurantFoundViewModel {
  var actionButtonTitle: String { get }

  var onAdjustPreferencesTapped: (() -> Void)? { get set }
}

final class NoRestaurantFoundViewModelImpl {
  let actionButtonTitle = "ADJUST PREFERENCES".localize()

  var onAdjustPreferencesTapped: (() -> Void)?
}

extension NoRestaurantFoundViewModelImpl: NoRestaurantFoundViewModel {}
