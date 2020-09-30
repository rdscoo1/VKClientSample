//
//  LikeControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 24.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    private let likeImageView = UIImageView(image: .heartIcon)
    private let likeCounterLabel = UILabel()
    private var likeCounter = Int()
    private var isLiked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLikeControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLikeControl()
    }
    
    func updateLikeControl(quantity: Int) {
        if quantity > 0 {
            self.likeCounter = quantity
            likeCounterLabel.text = "\(quantity)"
        }
    }
    
    private func configureLikeControl() {
        likeImageView.tintColor = Constants.Colors.vkGray
        
        likeCounterLabel.textColor = Constants.Colors.vkGray
        likeCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        addSubview(likeImageView)
        addSubview(likeCounterLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLike))
        addGestureRecognizer(tap)
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        likeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCounterLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 4).isActive = true
        likeCounterLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor).isActive = true
    }
    
    @objc private func tappedLike() {
        isLiked = !isLiked
        
        if isLiked {
            likeCounterLabel.text = "\(likeCounter + 1)"
            likeImageView.image = .heartFill
            likeImageView.tintColor = .red
            UIView.animate(withDuration: 0.3, animations: {
                self.likeCounterLabel.textColor = .red
                self.layoutIfNeeded()
            })
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        } else {
            likeCounterLabel.text = "\(likeCounter)"
            likeImageView.image = .heartIcon
            likeImageView.tintColor = .gray
            
            UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
                self.likeCounterLabel.textColor = Constants.Colors.vkGray
                self.layoutIfNeeded()
            })
        }
        
        animateButtonTap()
    }
    
    private func animateButtonTap() {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: {
                self.likeImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.5,
                options: .curveEaseIn,
                animations: {
                    self.likeImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}
