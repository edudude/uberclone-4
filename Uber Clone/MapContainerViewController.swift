//
//  MapContainerViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 25/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit

class MapContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Converted to Swift 4 by Swiftify v4.1.6621 - https://objectivec2swift.com/
        let myNav:UINavigationController = storyboard?.instantiateViewController(withIdentifier: "mapScreen") as! UINavigationController
        myNav.willMove(toParentViewController: self)
        myNav.view.frame = view.frame
        //Set a frame or constraints
        view.addSubview(myNav.view)
        addChildViewController(myNav)
        myNav.didMove(toParentViewController: self)

    }
}
