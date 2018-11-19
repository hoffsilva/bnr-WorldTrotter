//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Hoff Henry Pereira da Silva on 18/11/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        //create a map view
        mapView = MKMapView()
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        //set it as *the* view of this view controller
        view = mapView
        setSegmentedControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self

        locationManager.startUpdatingLocation()
        print("Map view controller loaded its view.")
    }

    private func setSegmentedControl() {
        let segmentedControl    = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)

        let topConstraint       = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
        let leadConstraint      = segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint  = segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)

        view.addSubview(segmentedControl)

        activeConstraint(constraint: topConstraint)
        activeConstraint(constraint: leadConstraint)
        activeConstraint(constraint: trailingConstraint)

    }

    private func setButton() {
        let button = UIButton()
        button.titleLabel?.text = "My Location"
        button.addTarget(self, action: #selector(MapViewController.getMyLocation(_:)), for: .touchUpInside)

        mapView.addSubview(button)

        activeConstraint(constraint: button.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor, constant: 10))
        activeConstraint(constraint: button.trailingAnchor.constraint(equalTo: mapView.layoutMarginsGuide.trailingAnchor, constant: 30))
    }

    private func activeConstraint(constraint: NSLayoutConstraint) {
        constraint.isActive     = true
    }

    @objc
    private func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    @objc
    private func getMyLocation(_ button: UIButton) {
        locationManager.startUpdatingLocation()
    }
}

extension MapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print(error.localizedDescription)
    }

    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.mapView.centerCoordinate = userLocation.coordinate
        self.mapView.isZoomEnabled = true
    }
}

extension MapViewController: CLLocationManagerDelegate {

}


