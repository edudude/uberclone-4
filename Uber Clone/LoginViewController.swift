//
//  ViewController.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 17/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController{

    fileprivate var accountKit = AKFAccountKit(responseType: .accessToken)
    fileprivate var pendingLoginViewController: AKFViewController? = nil
    fileprivate var showAccountOnAppear = false
    
    @IBOutlet weak var uberTextIconContainer: UIView!
    @IBOutlet weak var backgroundTeal: UIView!
    @IBOutlet weak var bottombar: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAccountOnAppear = accountKit.currentAccessToken != nil
        pendingLoginViewController = accountKit.viewControllerForLoginResume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showAccountOnAppear {
            showAccountOnAppear = false
            //presentWithSegueIdentifier("showAccount", animated: true)
            print(accountKit.currentAccessToken?.tokenString ?? "no access token")
        } else if let viewController = pendingLoginViewController {
            prepareLoginViewController(viewController)
            if let viewController = viewController as? UIViewController {
                present(viewController, animated: animated, completion: nil)
                pendingLoginViewController = nil
            }
        }
        animateAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(accountKit.currentAccessToken != nil){
            showAddName(phoneNumber: (accountKit.currentAccessToken?.accountID)!)
        }
    }

    func animateAll() {
        //toPresenter.uberTextIcon.animate(1).translate(-50, -50)
        let parentFrame = view.frame
        backgroundTeal.frame = parentFrame
        bottombar.frame = CGRect(x: 0, y: parentFrame.height, width: parentFrame.width, height: parentFrame.height*0.3)
        uberTextIconContainer.center.x = view.center.x
        loginButton.center.x = view.center.x
        loginButton.center.y = bottombar.frame.height/2
        nextButton.center.y = bottombar.frame.height - 40
        nextButton.center.x = bottombar.frame.width - 50
        
        enterName.frame = CGRect(x: 10, y: 80, width: bottombar.frame.width - 20, height: 50)
        phoneNumberLabel.frame = CGRect(x: 10, y: 10, width: bottombar.frame.width - 20, height: 30)
        phoneNumberLabel.text = ""
        
        loginButton.isHidden = false
        nextButton.isHidden = true
        enterName.isHidden = true
        phoneNumberLabel.isHidden = true
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            self.uberTextIconContainer.transform = CGAffineTransform(scaleX: 6,y: 6)
            self.uberTextIconContainer.center = CGPoint(x: self.uberTextIconContainer.center.x, y: 220)
            self.uberTextIconContainer.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseIn, animations: {
            self.backgroundTeal.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.80, delay: 0.0, options: .curveEaseInOut, animations: {
            self.bottombar.frame = CGRect(x: 0, y: parentFrame.height*0.7, width: parentFrame.width, height: parentFrame.height*0.3)
        }, completion: nil)
    }
    
    func prepareLoginViewController(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
    }
    
    func presentWithSegueIdentifier(_ segueIdentifier: String, animated: Bool) {
        if animated {
            //performSegue(withIdentifier: segueIdentifier, sender: nil)
        } else {
            UIView.performWithoutAnimation {
                self.performSegue(withIdentifier: segueIdentifier, sender: nil)
            }
        }
    }
    
    func showAddName(phoneNumber:String){
        loginButton.isHidden = true
        nextButton.isHidden = false
        enterName.isHidden = false
        phoneNumberLabel.isHidden = false
        
        phoneNumberLabel.text = phoneNumber + " (verified)"
    }
    
    
    // MARK: - Navigation
    @IBAction func loginWithPhone(_ sender: Any) {
        let accountViewController = storyboard?.instantiateViewController(withIdentifier: "accountScreen") as! AccountViewController
        
        present(accountViewController, animated: true, completion: nil)
        /**
        if let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: nil) as AKFViewController? {
            prepareLoginViewController(viewController)
            if let viewController = viewController as? UIViewController {
                present(viewController, animated: true, completion: nil)
            }
        }**/
    }
    
}

extension LoginViewController :  AKFViewControllerDelegate {
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        showAddName(phoneNumber: accessToken.accountID)
        //presentWithSegueIdentifier("showAccount", animated: true)
        print(accessToken.tokenString)
        
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        print("\(viewController) did fail with error: \(error)")
    }
}

