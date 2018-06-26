//
//  RestaurantMapCell.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-25.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import MapKit


final class RestaurantMapCell: UITableViewCell {
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var openMapsButton: UIButton!
  @IBOutlet weak var openMapsButtonLabel: UILabel!

  fileprivate var viewModel: RestaurantMapCellViewModel?

  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyling()
  }

  func configure(with viewModel: RestaurantMapCellViewModel) {
    self.viewModel = viewModel
    openMapsButtonLabel.text = viewModel.openMapsButtonTitle

    let annotation = MKPointAnnotation()
    annotation.coordinate = viewModel.location
    annotation.title = viewModel.restaurantName
    mapView.addAnnotation(annotation)

    mapView.selectAnnotation(annotation, animated: false)
    mapView.showAnnotations([annotation], animated: false)
  }

  private func applyStyling() {
    openMapsButton.layer.cornerRadius = 24
    openMapsButton.layer.shadowColor = UIColor.black.cgColor
    openMapsButton.layer.shadowRadius = 14
    openMapsButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    openMapsButton.layer.shadowOpacity = 0.15
    openMapsButton.layer.backgroundColor = UIColor.white.cgColor

    openMapsButtonLabel.font = Font.bold(size: 14)
    openMapsButtonLabel.textColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)

    selectionStyle = .none

    mapView.showsUserLocation = true
    mapView.isUserInteractionEnabled = false
  }

  @IBAction private func openMapsButtonTapped() {
    guard let viewModel = viewModel else { return }
    let placemark = MKPlacemark(coordinate: viewModel.location, addressDictionary: viewModel.addressDictionary)
    let mapItem = MKMapItem(placemark: placemark)
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
    mapItem.openInMaps(launchOptions: launchOptions)
  }
}
