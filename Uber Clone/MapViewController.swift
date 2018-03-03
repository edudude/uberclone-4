//
//  AccountViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {


    var locationManager : CLLocationManager = CLLocationManager()
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let googlemapsapikey = "AIzaSyA2WLvreHIIAiFnejU3gJiuI_mkzn4kjpw"
        navigationItem.title = "Hello Map"
        GMSServices.provideAPIKey(googlemapsapikey)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MapViewController:GMSMapViewDelegate {
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        mapView.isHidden = false
    }
}

extension MapViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        print(lastLocation.coordinate.latitude)
        print(lastLocation.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude:lastLocation.coordinate.latitude,
                                              longitude: lastLocation.coordinate.longitude,
                                              zoom: 14)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.mapView = GMSMapView.map(withFrame:  self.view.frame, camera: camera)
            self.mapView.settings.compassButton = true
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.myLocationButton = true
            self.mapView.delegate = self
            
            let marker = GMSMarker()
            marker.position = camera.target
            marker.snippet = "Hello World"
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.map = self.mapView
            
            //only to unhide it when map is completely loaded
            self.mapView.isHidden = true
            self.view.addSubview(self.mapView)
            self.locationManager.stopUpdatingLocation()
        }
    }
}
