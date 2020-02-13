//
//  LikeControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 24.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    let likeImageView = UIImageView(image: .heart)
    let likeCounterLabel = UILabel()
    var likeCounter: Int = Int.random(in: 1...1000)
    var isLiked: Bool = false
    var likeCounterLabelConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLikeControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLikeControl()
    }
    
    func configureLikeControl() {
        addSubview(likeImageView)
        addSubview(likeCounterLabel)
        
        likeImageView.tintColor = .gray
        
        likeCounterLabel.textColor = .lightGray
        likeCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        likeCounterLabel.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLike))
        addGestureRecognizer(tap)
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        likeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCounterLabelConstraint = likeCounterLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: -4)
        likeCounterLabelConstraint.isActive = true
        likeCounterLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor).isActive = true
        
        updateLikeCounter()
    }
    
    @objc func tappedLike() {
        isLiked = !isLiked
        
        if isLiked {
            likeCounter += 1
            likeImageView.image = .heartFill
            likeImageView.tintColor = .red
            likeCounterLabel.textColor = .red
            likeCounterLabelConstraint.constant = 4
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
                self.likeCounterLabel.alpha = 1.0
            })
            animateButtonTap()
        } else {
            likeCounter -= 1
            likeImageView.image = .heart
            likeImageView.tintColor = .gray
            likeCounterLabel.textColor = .lightGray
            likeCounterLabelConstraint.constant = -4
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
                self.likeCounterLabel.alpha = 0.0
            })
            animateButtonTap()
        }
        
        updateLikeCounter()
    }
    
    func updateLikeCounter() {
        likeCounterLabel.text = "\(likeCounter)"
    }
    
    func animateButtonTap() {
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
