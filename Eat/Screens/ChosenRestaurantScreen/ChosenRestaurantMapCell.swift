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
    mapView.addSubview(googleMap)

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: restaurant.lat, longitude: restaurant.lon)
    marker.title = restaurant.name
    marker.map = googleMap
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Add the button object
    let btn: UIButton = UIButton(type: UIButtonType.roundedRect)
    btn.frame = CGRect(x: 85, y: 150, width: 215, height: 60)
    btn.setBackgroundImage(#imageLiteral(resourceName: "MapButton"), for: UIControlState.normal)
    btn.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    self.addSubview(btn)

    // Add the overlaying text
    let myText: UILabel = UILabel(frame: CGRect(x: 137, y: 147, width: 206, height: 56))
    myText.text = "Open in Google Maps"
    myText.font = UIFont.systemFont(ofSize: 14)
    myText.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)
    self.addSubview(myText)

    // Add the image
    let myImage: UIImage = #imageLiteral(resourceName: "DirectionIcon")
    let imageView = UIImageView(image: myImage)
    imageView.frame = CGRect(x: 108, y: 161, width: 24.55, height: 27)
    self.addSubview(imageView)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  @objc private func buttonClicked() {
    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
    {
      UIApplication.shared.openURL(NSURL(string:
        "comgooglemaps://?saddr=&daddr=\(Float(myRestaurant.lat)),\(Float(myRestaurant.lon))&directionsmode=driving")! as URL)
    } else
    {
      NSLog("Can't use com.google.maps://");
    }
  }
}