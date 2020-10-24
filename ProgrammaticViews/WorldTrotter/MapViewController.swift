// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        
        mapView = MKMapView()
        view = mapView
        
        //Adding Segmented Control
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //Adding POI Label
        let pointsOfInterest = UILabel()
        pointsOfInterest.text = "Points of Interest"
        pointsOfInterest.textAlignment = .center
        pointsOfInterest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointsOfInterest)
        
        let topConstraintOfLabel = pointsOfInterest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55)
        let leadingConstraintOfLabel = pointsOfInterest.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        
        
        topConstraintOfLabel.isActive = true
        leadingConstraintOfLabel.isActive = true
        
        //Adding POI Switch
        
        let pointOfInterestSwitch = UISwitch()
        pointOfInterestSwitch.addTarget(self, action: #selector(displayPointsOfInterest(_:)), for: .valueChanged)
        pointOfInterestSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointOfInterestSwitch)
        
        let topConstraintSwitch = pointOfInterestSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        let leadingConstraintSwitch = pointOfInterestSwitch.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: pointsOfInterest.leadingAnchor, multiplier: 18)
        
        topConstraintSwitch.isActive = true
        leadingConstraintSwitch.isActive = true
        
        
    }
    
      override func viewDidLoad() {
            super.viewDidLoad()
            
            print("MapViewController loaded its view.")
        }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {

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
    
    @objc func displayPointsOfInterest(_ toggleSwitch: UISwitch) {
            
        if toggleSwitch.isOn {
            /*
            mapView.pointOfInterestFilter = .includingAll
            print(mapView.pointOfInterestFilter = .includingAll) */
            let coordinate = CLLocationCoordinate2D(
                        latitude: 12.9352, longitude: 77.6244)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            mapView.pointOfInterestFilter = .some(MKPointOfInterestFilter(including: [.restaurant, .park, .brewery]))
        } else {
            mapView.pointOfInterestFilter = .excludingAll
        }

    }
        
}
  
