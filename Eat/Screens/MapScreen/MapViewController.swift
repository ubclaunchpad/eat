//
//  MapViewController.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-18.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {
  fileprivate struct Constants {
    static let zoomLevel: Float = 13
    static let actionButtonKern: CGFloat = 2
  }

  @IBOutlet var mapView: GMSMapView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var instructionLabel: UILabel!

  var viewModel: MapViewModel

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
    viewModel.fetchLocation()
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

    self.view.bringSubview(toFront: nextButton)
  }

  func configure() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.navigationButton, style: .plain, target: self, action: #selector(didTapNext))

    let camera = GMSCameraPosition.camera(withLatitude: viewModel.defaultLocation.coordinate.latitude,
                                          longitude: viewModel.defaultLocation.coordinate.longitude,
                                          zoom: Constants.zoomLevel)
    self.mapView.camera = camera

    self.mapView.settings.setAllGesturesEnabled(true)
    self.mapView.isUserInteractionEnabled = true
    self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.mapView.padding = UIEdgeInsetsMake(0, 0, 100, 0)

    viewModel.onLocationAuthorized = locationAuthorized
    viewModel.onLocationUpdated = locationUpdated
  }

  func locationAuthorized() {
    self.mapView.settings.myLocationButton = true
    self.mapView.isMyLocationEnabled = true
  }

  func locationUpdated(location: CLLocation) {
    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Constants.zoomLevel)

    if self.mapView.isHidden {
      self.mapView.isHidden = false
      self.mapView.camera = camera
    } else {
      self.mapView.animate(to: camera)
    }
  }
}

// MARK: Actions
extension MapViewController {
  @objc func didTapNext() {
    let target = self.mapView.camera.target
    let edge = self.mapView.projection.visibleRegion().farRight

    viewModel.didTapNext(targetLatitude: Float(target.latitude), targetLongitude: Float(target.longitude), edgeLongitude: Float(edge.longitude))
  }
}
