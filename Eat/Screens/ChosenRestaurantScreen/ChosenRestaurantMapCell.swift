//
//  ChosenRestaurantMapCell.swift
//  Eat
//
//  Created by Henry Jones on 2018-03-17.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import GoogleMaps

class ChosenRestaurantMapCell: UITableViewCell {

  @IBOutlet weak var mapView: UIView!
  @IBOutlet weak var openMapsButton: UIButton!
  @IBOutlet weak var openMapsButtonLabel: UILabel!

  var myRestaurant: Restaurant!

  func configure(restaurant: Restaurant) {

    myRestaurant = restaurant
    let camera = GMSCameraPosition.camera(withLatitude: restaurant.lat, longitude: restaurant.lon, zoom: 15.0)
    let googleMap = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
    googleMap.settings.myLocationButton = true
    googleMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    googleMap.settings.setAllGesturesEnabled(false)
    googleMap.settings.compassButton = false
    googleMap.settings.myLocationButton = false
    //mapView.isMyLocationEnabled = true

    // Add the map to the view, hide it until we've got a location update.
    mapView.insertSubview(googleMap, at: 0)

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: restaurant.lat, longitude: restaurant.lon)
    marker.title = restaurant.name
    marker.map = googleMap
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    setButton()
  }

  private func setButton() {
    openMapsButton.layer.cornerRadius = 24
    openMapsButton.layer.shadowColor = UIColor.black.cgColor
    openMapsButton.layer.shadowRadius = 14
    openMapsButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    openMapsButton.layer.shadowOpacity = 0.15
    openMapsButton.layer.backgroundColor = UIColor.white.cgColor

    openMapsButtonLabel.font = Font.bold(size: 14)
    openMapsButtonLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)
    openMapsButtonLabel.text = "Open in Google Maps"
  }

  @IBAction private func openMapsButtonTapped() {
    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
      UIApplication.shared.openURL(NSURL(string:
        "comgooglemaps://?saddr=&daddr=\(Float(myRestaurant.lat)),\(Float(myRestaurant.lon))&directionsmode=driving")! as URL)
    } else {
      NSLog("Can't use com.google.maps://");
    }
  }
}
