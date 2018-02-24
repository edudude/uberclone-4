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
        
        let myNav:UINavigationController = storyboard?.instantiateViewController(withIdentifier: "mapScreen") as! UINavigationController
        myNav.willMove(toParentViewController: self)
        myNav.view.frame = view.frame
        view.addSubview(myNav.view)
        addChildViewController(myNav)
        myNav.didMove(toParentViewController: self)

    }
}
