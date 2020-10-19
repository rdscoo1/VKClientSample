//
//  DoneIconView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/19/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class DoneIconView: UIView {

    func animate() {
        let length = frame.width
        let animatablePath = UIBezierPath()
        animatablePath.move(to: CGPoint(x: length * 0.16, y: length * 0.5))
        animatablePath.addLine(to: CGPoint(x: length * 0.48, y: length * 0.84))
        animatablePath.addLine(to: CGPoint(x: length * 1.1, y: length * 0.2))
        
        let animatableLayer = CAShapeLayer()
        animatableLayer.path = animatablePath.cgPath
        animatableLayer.fillColor = UIColor.clear.cgColor
        animatableLayer.strokeColor = Constants.Colors.vkGray.cgColor
        animatableLayer.lineWidth = 3
        animatableLayer.lineCap = .round
        animatableLayer.lineJoin = .round
        animatableLayer.strokeEnd = 0
        self.layer.addSublayer(animatableLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.3
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animatableLayer.strokeEnd = 1
        animatableLayer.add(animation, forKey: "animation")
    }
}
