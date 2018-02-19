//
//  CircularTransition.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 19/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//
import UIKit

protocol CircleTransitionable {
    var triggerButton: UIButton { get }
    var contentTextView: UITextView { get }
    var mainView: UIView { get }
}

class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {
    weak var context: UIViewControllerContextTransitioning?
    
    //make this zero for now and see if it matters when it comes time to make it interactive
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CircleTransitionable,
            let toVC = transitionContext.viewController(forKey: .to) as? CircleTransitionable,
            let snapshot = fromVC.mainView.snapshotView(afterScreenUpdates: false) else {
                transitionContext.completeTransition(false)
                return
        }
        
        context = transitionContext
        
        let containerView = transitionContext.containerView
        
        //Background View With Correct Color
        let backgroundView = UIView()
        backgroundView.frame = toVC.mainView.frame
        backgroundView.backgroundColor = fromVC.mainView.backgroundColor
        containerView.addSubview(backgroundView)
        
        //Animate old view offscreen
        containerView.addSubview(snapshot)
        fromVC.mainView.removeFromSuperview()
        animateOldTextOffscreen(fromView: snapshot)
        
        //Growing Circular Mask
        containerView.addSubview(toVC.mainView)
        animate(toView: toVC.mainView, fromTriggerButton: fromVC.triggerButton)
        
        //Animate Text in with a Fade
        animateToTextView(toTextView: toVC.contentTextView, fromTriggerButton: fromVC.triggerButton)
    }
    
    func animateOldTextOffscreen(fromView: UIView) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseIn], animations: {
            fromView.center = CGPoint(x: fromView.center.x - 1000, y: fromView.center.y + 1500)
            fromView.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
        }, completion: nil)
    }
    func animate(toView: UIView, fromTriggerButton triggerButton: UIButton) {
        //Starting Path
        let rect = CGRect(x: triggerButton.frame.origin.x,
                          y: triggerButton.frame.origin.y,
                          width: triggerButton.frame.width,
                          height: triggerButton.frame.width)
        let circleMaskPathInitial = UIBezierPath(ovalIn: rect)
        
        //Destination Path
        let fullHeight = toView.bounds.height
        let extremePoint = CGPoint(x: triggerButton.center.x,
                                   y: triggerButton.center.y - fullHeight)
        let radius = sqrt((extremePoint.x*extremePoint.x) +
            (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: triggerButton.frame.insetBy(dx: -radius,
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
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func animateToTextView(toTextView: UIView, fromTriggerButton: UIButton) {
        //Start toView offscreen a little and animate it to normal
        let originalCenter = toTextView.center
        toTextView.alpha = 0.0
        toTextView.center = fromTriggerButton.center
        toTextView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.25, delay: 0.1, options: [.curveEaseOut], animations: {
            toTextView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            toTextView.center = originalCenter
            toTextView.alpha = 1.0
        }, completion: nil)
    }
}

extension CircularTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        context?.completeTransition(true)
    }
}
