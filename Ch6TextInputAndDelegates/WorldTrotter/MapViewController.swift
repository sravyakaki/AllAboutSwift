// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true


//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
        print("MapViewController loaded its view.")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = locations.first!
        let coordinateRegion = MKCoordinateRegion(center: locations.coordinate,latitudinalMeters: 500,longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
        //locationManager.stopUpdatingLocation()
        
        
    }
}
