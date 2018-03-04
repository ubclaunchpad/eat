//
//  MapScreenController.swift
//  Eat
//
//  Created by Yonni Luu on 2018-03-03.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlacePicker
import GooglePlaces

class MapScreenController: GMSPlacePickerViewController{

  var locationManager = CLLocationManager()
  var currentLocation = CLLocation?.self
  var mapView: GMSMapView!
  var placesClient: GMSPlacesClient!
  var zoomLevel: Float = 15.0

  // Whether a user has selected a location other than their current location.
  // If this value is true, then the map should not recenter when the user's location
  // changes.
  // This value is reset to false when a user clicks on the current location icon where
  // the map recenters at that location
  var didSelect: Bool = false

  // A default location to use when location permission is not granted.
  let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)

  // The currently selected place.
  var selectedPlace: GMSPlace?

  override func loadView() {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    let camera = GMSCameraPosition.camera(withLatitude: 56.26, longitude: -139.98, zoom: 6.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize location manager
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.distanceFilter = 50

    // Location manager should start fetching current location
    locationManager.startUpdatingLocation()
    locationManager.delegate = self


    // Create a map.
    let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                          longitude: defaultLocation.coordinate.longitude,
                                          zoom: zoomLevel)
    mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
    mapView.settings.myLocationButton = true
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    mapView.isMyLocationEnabled = true
    mapView.delegate = self

  }
}

extension MapScreenController : CLLocationManagerDelegate {

  // Handle incoming location events.
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    // get the most recent location of the last locations
    let location: CLLocation = locations.last!
    print("Last Location: \(location)")

    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)

    // Check if the map should recenter for that incoming location change
    if (!didSelect){
      if self.mapView.isHidden {
        self.mapView.isHidden = false
        self.mapView.camera = camera
      } else {
        self.mapView.animate(to: camera)
      }
    }
    // Update the view
    view = mapView
  }

}

extension MapScreenController : GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
  {
    print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")

    // Set didSelect to true as map should not recenter if the user's current location
    // changes
    didSelect = true
    mapView.clear()
    let marker = GMSMarker(position: coordinate)
    marker.map = mapView

   let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: zoomLevel)
    if self.mapView.isHidden {
      self.mapView.isHidden = false
      self.mapView.camera = camera
    } else {
      self.mapView.animate(to: camera)
    }

    // Update the view object
    view = mapView
  }
  func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
    didSelect = false

    // Default behaviour for false is for the map to recenter at the user's current location
    return false
  }
}


