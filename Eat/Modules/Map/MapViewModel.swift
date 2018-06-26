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
  var defaultLocation: CLLocationCoordinate2D { get }

  func requestLocationAuthorization()
  func didTapNext(centerLocation: CLLocation, edgeLocation: CLLocation)

  var onTapNext: ((SearchQuery) -> Void)? { get set }

  var onLocationAuthorized: (() -> Void)? { get set }
  var onLocationUpdated: ((CLLocation) -> Void)? { get set }
}

final class MapViewModelImpl {
  fileprivate struct Constants {
    static let latitudeConversion: Float = 111
  }
  let navigationButton = "Next".localize()
  let questionText = "Where do you want to eat?".localize()
  let instructionText = "Drag to select the active map area".localize()
  let actionText = "NEXT".localize()
  let defaultLocation = CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207)

  let searchQuery = SearchQuery()
  let locationManager = LocationManager()
  let locationAuthManager = LocationAuthorizationManager()

  // Coordinator Handlers
  var onTapNext: ((SearchQuery) -> Void)?

  // View Controller Handlers
  var onLocationAuthorized: (() -> Void)?
  var onLocationUpdated: ((CLLocation) -> Void)?

  fileprivate func buildSearchQuery(centerLocation: CLLocation, edgeLocation: CLLocation) -> SearchQuery {
    let radius = centerLocation.distance(from: edgeLocation)

    searchQuery.latitude = centerLocation.coordinate.latitude
    searchQuery.longitude = centerLocation.coordinate.longitude
    searchQuery.radius = Int(radius)
    return searchQuery
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

  func didTapNext(centerLocation: CLLocation, edgeLocation: CLLocation) {
    onTapNext?(buildSearchQuery(centerLocation: centerLocation, edgeLocation: edgeLocation))
  }
}
