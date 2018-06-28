//
//  MapViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
  fileprivate struct Constants {
    static let zoomLevel: Float = 13
    static let actionButtonKern: CGFloat = 2
    static let regionRadius: CLLocationDistance = 1000
  }

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var instructionLabel: UILabel!

  var viewModel: MapViewModel

  var userLocation: CLLocationCoordinate2D?

  init(viewModel: MapViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyling()
    configure()
    viewModel.requestLocationAuthorization()
  }

  func applyStyling() {
    headerView.layer.shadowRadius = 5
    headerView.layer.shadowOffset = CGSize(width: 0, height: 9)
    headerView.layer.shadowColor = UIColor.black.cgColor
    headerView.layer.shadowOpacity = 0.25

    questionLabel.text = viewModel.questionText
    questionLabel.font = Font.onboarding(size: 13)
    questionLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4352941176, blue: 0.6, alpha: 1)

    instructionLabel.text = viewModel.instructionText
    instructionLabel.font = Font.onboarding(size: 13)
    instructionLabel.textColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)

    let actionText = NSMutableAttributedString(string: viewModel.actionText)
    actionText.addAttributes([NSAttributedStringKey.kern: Constants.actionButtonKern, NSAttributedStringKey.foregroundColor : UIColor.white], range: NSRange(location: 0, length: actionText.length))
    nextButton.setAttributedTitle(actionText, for: .normal)

    nextButton.titleLabel?.font = Font.onboardingAction(size: 17)
    nextButton.layer.cornerRadius = 16
    nextButton.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.4117647059, blue: 0.9960784314, alpha: 1)
    nextButton.accessibilityIdentifier = Accessibility.mapNext

    mapView.accessibilityIdentifier = Accessibility.mapView
    mapView.showsUserLocation = true

    self.view.bringSubview(toFront: nextButton)
  }

  func configure() {
    mapView.delegate = self

    let region = MKCoordinateRegionMakeWithDistance(viewModel.defaultLocation, Constants.regionRadius, Constants.regionRadius)
    mapView.setRegion(region, animated: true)
    mapView.userLocation.title = ""
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    if self.userLocation == nil {
      let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, Constants.regionRadius, Constants.regionRadius)
      mapView.setRegion(region, animated: true)
      self.userLocation = userLocation.coordinate
    }
  }
}

// MARK: Actions
extension MapViewController {
  @IBAction private func didTapNext() {
    let center = CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude)
    let latitudeOffset = mapView.region.span.latitudeDelta
    let edgeCoordinate = CLLocation(latitude: mapView.region.center.latitude + latitudeOffset, longitude: mapView.region.center.longitude)

    viewModel.didTapNext(centerLocation: center, edgeLocation: edgeCoordinate)
  }
}
