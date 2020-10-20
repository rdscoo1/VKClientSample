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
    
    var circleLayer: CAShapeLayer!
    
//    lazy var circleLayer: CAShapeLayer = {
   //
   //    }()
    
    //MARK: - Variables
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        configureCircle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func startAnimating() {
        addRotation()
        
        if isAnimating {
            return
        }
        
        if hidesWhenStopped {
            self.isHidden = false
        }
        resume(layer: circleLayer)
    }
    
    func stopAnimating() {
        if hidesWhenStopped {
            self.isHidden = true
        }
        pause(layer: circleLayer)
    }
    
    func settingStrokeEnd(value: CGFloat) {
        circleLayer.strokeEnd = value
    }
    
    //MARK: - Private Methods
    
    private func configureCircle() {
        let radius = (frame.size.width - 10)/2
        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = CGFloat(5 * Double.pi / 4)
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2,
                                                         y: frame.size.width / 2),
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = Constants.Colors.vkGray.cgColor
        circleLayer.lineWidth = 5.0
        circleLayer.lineCap = .round
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        self.layer.addSublayer(circleLayer)
        
//        addRotation()
    }
    
    private func addRotation() {
        circleLayer.strokeEnd = 1.0
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * 2)
        
        layer.add(rotation, forKey: "rotate")
    }
    
    private func pause(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        isAnimating = false
    }
    
    private func resume(layer: CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        
        isAnimating = true
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
