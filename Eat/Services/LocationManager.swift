//
//  LocationManager.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import CoreLocation

final class LocationManager: NSObject {
  fileprivate struct Constants {
    static let distanceFilter: Double = 50
  }

  let manager = CLLocationManager()

  var didUpdateLocation: ((CLLocation) -> Void)?

  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = Constants.distanceFilter
    manager.startUpdatingLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let recentLocation = locations.last else { return }
    didUpdateLocation?(recentLocation)
  }
}
