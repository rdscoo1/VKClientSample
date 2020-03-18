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
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let toVCViewTargetFrame = fromVC.view.frame

        containerView.addSubview(toVC.view)

        fromVC.view.frame = containerView.frame
        toVC.view.frame = CGRect(x: containerView.frame.width * 2,
                                 y: -containerView.frame.height / 2,
                                 width: fromVC.view.frame.width,
                                 height: fromVC.view.frame.height)
        toVC.view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))


        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 1/2,
                                                       animations: {
                                                        fromVC.view.transform = self.transform(rotationAngle: CGFloat(Double.pi / 2), translationX: -fromVC.view.frame.height, y: -(fromVC.view.frame.width / 2))
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 1/2,
                                                       relativeDuration: 1/2,
                                                       animations: {
                                                        toVC.view.transform = .identity
                                                        toVC.view.frame = toVCViewTargetFrame
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                toVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
    
    private func transform(rotationAngle: CGFloat, translationX: CGFloat, y: CGFloat) -> CGAffineTransform {
        let rotation = CGAffineTransform(rotationAngle: rotationAngle)
        let moveOut = CGAffineTransform(translationX: translationX, y: y)
        return rotation.concatenating(moveOut)
    }
}


class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1.4

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let toVCViewTargetFrame = fromVC.view.frame

        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)


        fromVC.view.frame = containerView.frame
        toVC.view.frame = CGRect(x: -containerView.frame.width * 2,
                                 y: -containerView.frame.height / 2,
                                 width: containerView.frame.width,
                                 height: containerView.frame.height)
        
        let rotate = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        toVC.view.transform = rotate


        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 1/2,
                                                       animations: {
                                                        fromVC.view.transform = self.transform(rotationAngle: CGFloat(-Double.pi / 2), translationX: fromVC.view.frame.height, y: -(fromVC.view.frame.width / 2))
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 1/2,
                                                       relativeDuration: 1/2,
                                                       animations: {
                                                        toVC.view.transform = .identity
                                                        toVC.view.frame = toVCViewTargetFrame
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                fromVC.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                toVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
    
    private func transform(rotationAngle: CGFloat, translationX: CGFloat, y: CGFloat) -> CGAffineTransform {
        let rotation = CGAffineTransform(rotationAngle: rotationAngle)
        let moveOut = CGAffineTransform(translationX: translationX, y: y)
        return rotation.concatenating(moveOut)
    }
}
