//
//  TransitionCoordinator.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit

class AnimationDelegate: NSObject, UINavigationControllerDelegate {
    
    
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print(operation.rawValue)
        if operation==UINavigationControllerOperation.pop {
            return nil
        } else {
            return CircularTransitionPush()
            
        }
        
    }
}
