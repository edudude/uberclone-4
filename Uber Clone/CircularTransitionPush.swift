//
//  CircularTransitionPush.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit

class CircularTransitionPush: NSObject, UIViewControllerAnimatedTransitioning {
    weak var context: UIViewControllerContextTransitioning?
    
    //make this zero for now and see if it matters when it comes time to make it interactive
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)! as! FirstViewController
        let toVC = transitionContext.viewController(forKey: .to)! as! LoginViewController
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)!
        
        
        context = transitionContext
        
        let containerView = transitionContext.containerView
        
        //Background View With Correct Color
        let backgroundView = UIView()
        backgroundView.frame = toVC.view.frame
        backgroundView.backgroundColor = fromVC.view.backgroundColor
        containerView.addSubview(backgroundView)
        
        //Animate old view offscreen
        containerView.addSubview(snapshot)
        fromVC.view.removeFromSuperview()
        
        //Growing Circular Mask
        containerView.addSubview(toVC.view)
        animate(toView: toVC.view, toPresenter: toVC)
        
        //Animate Text in with a Fade
        //animateToTextView(toTextView: toVC.contentTextView, fromTriggerButton: fromVC.triggerButton)
    }
    
    
    func animate(toView: UIView, toPresenter: LoginViewController) {
        
        //Starting Path
        let rect = CGRect(x: toView.center.x-50,
                          y: toView.center.y-50,
                          width: 100,
                          height: 100)
        let circleMaskPathInitial = UIBezierPath(ovalIn: rect)
        
        //Destination Path
        let fullHeight = toView.bounds.height
        let extremePoint = CGPoint(x: toView.center.x,
                                   y: toView.center.y - fullHeight)
        let radius = sqrt((extremePoint.x*extremePoint.x) +
            (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: rect.insetBy(dx: -radius,
                                                                    dy: -radius))
        
        //Actual mask layer
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        toView.layer.mask = maskLayer
        
        //Mask Animation
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.delegate = self
        maskLayerAnimation.duration = 0.5
        maskLayer.add(maskLayerAnimation, forKey: "path")
        
        //toPresenter.uberTextIcon.animate(1).translate(-50, -50)
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            toPresenter.uberTextIconContainer.transform = CGAffineTransform(scaleX: 5,y: 5)
            toPresenter.uberTextIconContainer.center = CGPoint(x: toPresenter.uberTextIconContainer.center.x, y: 220)
            toPresenter.uberTextIconContainer.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseIn, animations: {
            toPresenter.backgroundTeal.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.80, delay: 0.0, options: .curveEaseInOut, animations: {
            toPresenter.bottombar.center = CGPoint(x: toPresenter.uberTextIconContainer.center.x, y: 620)
        }, completion: nil)

        
    }
    
    
}

extension CircularTransitionPush: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        context?.completeTransition(true)
    }
}

