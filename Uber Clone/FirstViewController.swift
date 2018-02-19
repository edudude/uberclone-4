//
//  FirstViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, CircleTransitionable {
  
    var triggerButton: UIButton
    
    var contentTextView: UITextView
    
    var mainView: UIView
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "loginScreen") as! ViewController
        
        present(loginViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.delegate = transitionCoordinator as? UINavigationControllerDelegate
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
