//
//  AccountViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit
import GoogleMaps

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let googlemapsapikey = "AIzaSyA2WLvreHIIAiFnejU3gJiuI_mkzn4kjpw"
        navigationItem.title = "Hello Map"
        GMSServices.provideAPIKey(googlemapsapikey)
        let camera = GMSCameraPosition.camera(withLatitude: -33.868,
                                              longitude: 151.2086,
                                              zoom: 14)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = "Hello World"
        //marker.appearAnimation = kGMSMarkerAnimationPop()
        marker.map = mapView
        
        view = mapView    }

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
