//
//  ViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 17/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit
import AccountKit

class ViewController: UIViewController, AKFViewControllerDelegate  {

    fileprivate var accountKit = AKFAccountKit(responseType: .accessToken)
    fileprivate var pendingLoginViewController: AKFViewController? = nil
    fileprivate var showAccountOnAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAccountOnAppear = accountKit.currentAccessToken != nil
        pendingLoginViewController = accountKit.viewControllerForLoginResume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showAccountOnAppear {
            showAccountOnAppear = false
            //presentWithSegueIdentifier("showAccount", animated: animated)
            print(accountKit.currentAccessToken?.tokenString ?? "no access token")
        } else if let viewController = pendingLoginViewController {
            prepareLoginViewController(viewController)
            if let viewController = viewController as? UIViewController {
                present(viewController, animated: animated, completion: nil)
                pendingLoginViewController = nil
            }
        }
    }
    
    //===============for account kit================
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        //presentWithSegueIdentifier("showAccount", animated: false)
        print(accessToken.tokenString)
        
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        print("\(viewController) did fail with error: \(error)")
    }
    
    
    func prepareLoginViewController(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
    }
    
    func presentWithSegueIdentifier(_ segueIdentifier: String, animated: Bool) {
        if animated {
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        } else {
            UIView.performWithoutAnimation {
                self.performSegue(withIdentifier: segueIdentifier, sender: nil)
            }
        }
    }
    
   
    
    // MARK: - Navigation
    @IBAction func loginWithPhone(_ sender: Any) {
        
        if let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: nil) as AKFViewController? {
            prepareLoginViewController(viewController)
            if let viewController = viewController as? UIViewController {
                present(viewController, animated: true, completion: nil)
            }
        }
    }
    
}

