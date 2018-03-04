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

class MapScreenController: UIViewController{

  var locationManager = CLLocationManager()
  var currentLocation = CLLocation?.self
  var mapView: GMSMapView!
  var zoomLevel: Float = 15.0

  // A default location to use when location permission is not granted.
  let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)

  override func loadView() {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    let camera = GMSCameraPosition.camera(withLatitude: 56.26, longitude: -139.98, zoom: 6.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView

    // Creates a marker in the center of the map.
    //    let marker = GMSMarker()
    //    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    //    marker.title = "Sydney"
    //    marker.snippet = "Australia"
    //    marker.map = mapView
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

  }
}
extension MapScreenController : CLLocationManagerDelegate {

  // Handle incoming location events.
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    // get the most recent location of the last locations
    let location: CLLocation = locations.last!
    print("Last Location: \(location)")

    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)

    if self.mapView.isHidden {
      self.mapView.isHidden = false
      self.mapView.camera = camera
    } else {
      self.mapView.animate(to: camera)
    }

    // Update the view object
    view = mapView
  }

}
