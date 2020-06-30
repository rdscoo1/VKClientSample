//
//  LoadView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 04.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit


class LoadView: UIView {
    
    private var circles = [CALayer]()
    private let containerView = UIView()

    init() {
        super.init(frame: .zero)
        setupCircles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCircles()
    }
    
    private func setupCircles() {
        let circleColor = UIColor.gray
        let circlesCount = 3
        let size: CGFloat = 10
        let offset: CGFloat = 5
        
        for i in 0..<circlesCount {
            let circle = CAShapeLayer()
            circle.opacity = 1
            circle.path = UIBezierPath(ovalIn: CGRect(
                x: (size + offset) * CGFloat(i),
                y: 10,
                width: size,
                height: size)).cgPath
            
            circle.fillColor = circleColor.cgColor
            containerView.layer.addSublayer(circle)
            circles.append(circle)
        }
        containerView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        addSubview(containerView)
        startAnimating()
    }
    
    private func startAnimating() {
        var offset: TimeInterval = 0.0
        circles.forEach {
            $0.removeAllAnimations()
            $0.add(scaleAnimation(offset), forKey: nil)
            offset = offset + 0.10
        }
    }
    
    private func scaleAnimation(_ after: TimeInterval = 0) -> CAAnimationGroup {
        let scaleDown = CABasicAnimation(keyPath: "opacity")
        scaleDown.beginTime = after
        scaleDown.fromValue = 0.1
        scaleDown.toValue = 1.0
        scaleDown.duration = 1
        scaleDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        let group = CAAnimationGroup()
        group.animations = [scaleDown]
        group.repeatCount = Float.infinity
        
        group.duration = CFTimeInterval(0.8)

        return group
    }
}
