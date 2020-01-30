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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLike))
        addGestureRecognizer(tap)
        updateLikeCounter()
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        likeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCounterLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 4).isActive = true
        likeCounterLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor).isActive = true
    }
    
    @objc func tappedLike() {
        isLiked = !isLiked
        
        if isLiked {
            likeCounter += 1
            likeImageView.image = .heartFill
            likeImageView.tintColor = .red
            likeCounterLabel.textColor = .red
        } else {
            likeCounter -= 1
            likeImageView.image = .heart
            likeImageView.tintColor = .gray
            likeCounterLabel.textColor = .lightGray
        }
        
        updateLikeCounter()
    }
    
    func updateLikeCounter() {
           likeCounterLabel.text = "\(likeCounter)"
       }
}
