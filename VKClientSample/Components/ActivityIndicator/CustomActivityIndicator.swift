//
//  CustomActivityIndicator.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/30/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CustomActivityIndicator: UIView {
    
    //MARK: - Private Properties
    
    private lazy var circleLayer: CAShapeLayer = {
        let radius = (frame.size.width - 10)/2
        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = CGFloat(5 * Double.pi / 4)
        
        // Making form of a circle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2,
                                                         y: frame.size.width / 2),
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = 3.0
        circleLayer.lineCap = .round
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.95
        
        return circleLayer
    }()
    
    //MARK: - Public Variables
    
    var isAnimating: Bool = false
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.layer.addSublayer(circleLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func startAnimating() {
        isAnimating = true
        spin()
    }
    
    func stopAnimating() {
        isAnimating = false
        layer.removeAnimation(forKey: "rotate")
    }
    
    func setStrokeEnd(value: CGFloat) {
        isAnimating = false
        circleLayer.strokeEnd = value
    }
    
    //MARK: - Private Methods
    
    private func spin() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * 2)
        
        layer.add(rotation, forKey: "rotate")
    }
    
    
    //MARK: - Animation with StrokeEnd
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 0.1
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
