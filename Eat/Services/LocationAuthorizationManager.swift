//
//  LocationAuthorizationManager.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import CoreLocation

enum LocationAuthResult {
  case authorized, notAuthorized
}

final class LocationAuthorizationManager: NSObject {
  let locationManager = CLLocationManager()

  var onAuthResult: ((LocationAuthResult) -> Void)?

  func requestWhenInUse(responseHandler: @escaping ((LocationAuthResult) -> Void)) {
    locationManager.delegate = self
    self.onAuthResult = responseHandler
    locationManager.requestWhenInUseAuthorization()
  }
}

extension LocationAuthorizationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      onAuthResult?(.authorized)
    default:
      onAuthResult?(.notAuthorized)
    }
  }
}
