//
//  MapViewModel.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import CoreLocation

protocol MapViewModel {
  var navigationButton: String { get }
  var questionText: String { get }
  var instructionText: String { get }
  var actionText: String { get }
  var defaultLocation: CLLocation { get }

  func requestLocationAuthorization()
  func fetchLocation()
  func didTapNext(targetLatitude: Float, targetLongitude: Float, edgeLongitude: Float)

  var onTapNext: ((SearchQuery) -> Void)? { get set }

  var onLocationAuthorized: (() -> Void)? { get set }
  var onLocationUpdated: ((CLLocation) -> Void)? { get set }
}

final class MapViewModelImpl {
  let navigationButton = "Next".localize()
  let questionText = "Where do you want to eat?".localize()
  let instructionText = "Drag to select the active map area".localize()
  let actionText = "NEXT".localize()
  let defaultLocation = CLLocation(latitude: 49.2827, longitude: -123.1207)

  let searchQuery = SearchQuery()
  let locationManager = LocationManager()
  let locationAuthManager = LocationAuthorizationManager()

  // Coordinator Handlers
  var onTapNext: ((SearchQuery) -> Void)?

  // View Controller Handlers
  var onLocationAuthorized: (() -> Void)?
  var onLocationUpdated: ((CLLocation) -> Void)?

  fileprivate func buildSearchQuery(targetLatitude: Float, targetLongitude: Float, edgeLongitude: Float) -> SearchQuery {
    let radius = getLongatudeRadius(center: targetLongitude, outerCoord: edgeLongitude)

    searchQuery.latitude = targetLatitude
    searchQuery.longitude = targetLongitude
    searchQuery.radius = radius
    return searchQuery
  }

  private func getLongatudeRadius(center: Float, outerCoord: Float) -> Int {
    let latDifference = abs(outerCoord - center)
    let radius = latDifference * (111 * 1000) //degree * (111km * 1000m/km)
    return Int(radius)
  }
}

extension MapViewModelImpl: MapViewModel {
  func requestLocationAuthorization() {
    locationAuthManager.requestWhenInUse { result in
      switch result {
      case .authorized:
        self.onLocationAuthorized?()
      case .notAuthorized:
        break
      }
    }
  }

  func fetchLocation() {
    locationManager.didUpdateLocation = onLocationUpdated
  }

  func didTapNext(targetLatitude: Float, targetLongitude: Float, edgeLongitude: Float) {
    onTapNext?(buildSearchQuery(targetLatitude: targetLatitude, targetLongitude: targetLongitude, edgeLongitude: edgeLongitude))
  }
}
