//
//  NavigationTransition.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 13.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1.4

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       guard let source = transitionContext.viewController(forKey: .from),
        let destinationVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        transitionContext.containerView.addSubview(destinationVC.view)
        destinationVC.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destinationVC.view.frame = source.view.frame
        destinationVC.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, animations: {
            destinationVC.view.transform = CGAffineTransform(rotationAngle: 0)
        }) { animationFinished in
            if animationFinished && !transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(true)
            }
        }
    }
}


class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1.4

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       guard let source = transitionContext.viewController(forKey: .from),
           let destinationVC = transitionContext.viewController(forKey: .to) else {
               return
       }
       
       transitionContext.containerView.addSubview(destinationVC.view)
       destinationVC.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
       destinationVC.view.frame = source.view.frame
       destinationVC.view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
       
       UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, animations: {
           destinationVC.view.transform = CGAffineTransform(rotationAngle: 0)
       }) { animationFinished in
           if animationFinished && !transitionContext.transitionWasCancelled {
               transitionContext.completeTransition(true)
           }
       }
        
    }
}
