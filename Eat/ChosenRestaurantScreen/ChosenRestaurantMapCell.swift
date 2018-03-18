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

  func configure(restaurant: Restaurant) {

    let camera = GMSCameraPosition.camera(withLatitude: 49.26626, longitude: -123.2408, zoom: 15.0)
    let googleMap = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
    googleMap.settings.myLocationButton = true
    googleMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //mapView.isMyLocationEnabled = true

    // Add the map to the view, hide it until we've got a location update.
    mapView.addSubview(googleMap)

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: 49.26626, longitude: -123.2408)
    marker.title = "Jam Jar"
    marker.map = googleMap
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
