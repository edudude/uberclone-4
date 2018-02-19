//
//  FirstViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
    let animationDelegate = AnimationDelegate()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = animationDelegate as UINavigationControllerDelegate

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "loginScreen") as! ViewController
        navigationController?.pushViewController(loginViewController, animated: true)
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
