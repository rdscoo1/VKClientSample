//
//  ErrorIconView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 11/2/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ErrorIconView: UIView {

    func animate() {
        animateTopToBottomLine()
        animateBottomToTopLine()
    }
        
    private func animateTopToBottomLine() {
        let length = frame.width
        
        let topToBottomLine = UIBezierPath()
        topToBottomLine.move(to: CGPoint(x: length * 0, y: length * 0))
        topToBottomLine.addLine(to: CGPoint(x: length * 1, y: length * 1))
        
        let animatableLayer = CAShapeLayer()
        animatableLayer.path = topToBottomLine.cgPath
        animatableLayer.fillColor = UIColor.clear.cgColor
        animatableLayer.strokeColor = tintColor?.cgColor
        animatableLayer.lineWidth = 9
        animatableLayer.lineCap = .round
        animatableLayer.lineJoin = .round
        animatableLayer.strokeEnd = 0
        self.layer.addSublayer(animatableLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.22
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        animatableLayer.strokeEnd = 1
        animatableLayer.add(animation, forKey: "animation")
    }
        
    private func animateBottomToTopLine() {
        let length = frame.width
        
        let bottomToTopLine = UIBezierPath()
        bottomToTopLine.move(to: CGPoint(x: length * 0, y: length * 1))
        bottomToTopLine.addLine(to: CGPoint(x: length * 1, y: length * 0))
        
        let animatableLayer = CAShapeLayer()
        animatableLayer.path = bottomToTopLine.cgPath
        animatableLayer.fillColor = UIColor.clear.cgColor
        animatableLayer.strokeColor = tintColor?.cgColor
        animatableLayer.lineWidth = 9
        animatableLayer.lineCap = .round
        animatableLayer.lineJoin = .round
        animatableLayer.strokeEnd = 0
        self.layer.addSublayer(animatableLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.22
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        animatableLayer.strokeEnd = 1
        animatableLayer.add(animation, forKey: "animation")
    }
}
