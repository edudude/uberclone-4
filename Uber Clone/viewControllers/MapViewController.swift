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
import GooglePlaces

class MapViewController: UIViewController {


    var locationManager : CLLocationManager = CLLocationManager()
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var fromandto: UIView!
    @IBOutlet weak var listOfPlacesContainer: UIView!
    @IBOutlet weak var wheretoView: UIView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var wheretoViewBack: UIImageView!
    
    @IBOutlet weak var chooseLocationTableView: UITableView!
    
    var results:[GMSAutocompletePrediction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let googlemapsapikey = "AIzaSyA2WLvreHIIAiFnejU3gJiuI_mkzn4kjpw"
        navigationItem.title = "Hello Map"
        GMSServices.provideAPIKey(googlemapsapikey)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        wheretoView.dropShadow()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showFromTo(sender:)))
        wheretoView.addGestureRecognizer(tap)
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.hideFromAndToView(sender:)))
        wheretoViewBack.isUserInteractionEnabled = true
        wheretoViewBack.addGestureRecognizer(backTap)
        
        chooseLocationTableView.delegate = self
        chooseLocationTableView.dataSource = self
        
        let whereTotap = UITapGestureRecognizer(target: self, action:  #selector(self.showChoosePlace(sender:)))
        toTextField.addGestureRecognizer(whereTotap)
        //toTextField.isUserInteractionEnabled = true
        GMSPlacesClient.provideAPIKey(googlemapsapikey)
        placesClient = GMSPlacesClient.shared()
        
    }

    
    @IBAction func toEditingChanged(_ sender: Any) {
        if toTextField.text != nil {
            getLocation()
        }
    }
    func getLocation(){
        let visibleRegion = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)

        placesClient.autocompleteQuery(toTextField.text!, bounds: bounds,filter: nil,
                                       callback: {
                                        (results,error) in
                                        self.results = results
                                        self.chooseLocationTableView.reloadData()
                                       }
                                    )
    }
    
    // MARK: - Navigation

    @objc func showFromTo(sender: UITapGestureRecognizer) {
        fromandto.alpha = 0
        fromandto.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.fromandto.alpha = 1
        }, completion: nil)
    }
    
    @objc func hideFromAndToView(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.fromandto.alpha = 0
            self.listOfPlacesContainer.alpha = 0
        }, completion: {(value:Bool) in
            self.fromandto.isHidden = true
            self.listOfPlacesContainer.isHidden = true
        })
    }
    
    @objc func showChoosePlace(sender: UITapGestureRecognizer){
        listOfPlacesContainer.alpha = 0
        listOfPlacesContainer.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.listOfPlacesContainer.alpha = 1
        }, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

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
            self.view.insertSubview(self.mapView, at: 0)
        }
        self.locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choosePlaceCell") as! ChoosePlaceTableViewCell
        cell.placeName.text = results?[indexPath.row].attributedPrimaryText.string ?? "nil"
        cell.placeLocation.text = results?[indexPath.row].attributedFullText.string ?? "nil"
        return cell
    }
}
