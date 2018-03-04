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

class MapScreenController: UIViewController{

  var locationManager = CLLocationManager()
  var currentLocation = CLLocation?.self
  var placesClient: GMSPlacesClient!
  var zoomLevel: Float = 15.0

  @IBOutlet var mapView: GMSMapView!

  

  // Whether a user has selected a location other than their current location.
  // If this value is true, then the map should not recenter when the user's location
  // changes.
  // This value is reset to false when a user clicks on the current location icon where
  // the map recenters at that location
  var didSelect: Bool = false

  // A default location to use when location permission is not granted.
  let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)

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
    self.mapView.camera = camera
    self.mapView.settings.myLocationButton = true
    self.mapView.settings.setAllGesturesEnabled(true)
    self.mapView.isUserInteractionEnabled = true
    self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.mapView.isMyLocationEnabled = true
    self.mapView.delegate = self

    // Add title to the navigation bar
    navigationItem.title = "Where do you want to eat?"
    // Add a next button to the navigation bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(MapScreenController.next(_:)))
  }
  @objc func next(_ sender:UIBarButtonItem!) {
    print("Next has been click")
    // TODO: create a search query object when this button is clicked and move onto the next
    //       screen
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
  }

}

extension MapScreenController : GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
  {
    print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")

    // Set didSelect to true as map should not recenter if the user's current location
    // changes
    didSelect = true

    // There should only be one pin on the map max
    self.mapView.clear()
    let marker = GMSMarker(position: coordinate)
    marker.map = self.mapView

   let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: zoomLevel)
    if self.mapView.isHidden {
      self.mapView.isHidden = false
      self.mapView.camera = camera
    } else {
      self.mapView.animate(to: camera)
    }
  }
  func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
    didSelect = false

    // Default behaviour for false is for the map to recenter at the user's current location
    return false
  }
}


