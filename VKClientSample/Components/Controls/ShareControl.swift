//
//  ShareControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ShareControl: UIControl {
    
    let shareImageView = UIImageView(image: .shareButton)
    let shareCounterLabel = UILabel(frame: CGRect(x: 28, y: 0, width: 40, height: 25))
    var shareCounter: Int = Int.random(in: 1...1000)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShareControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShareControl()
    }
    
    func configureShareControl() {
        addSubview(shareImageView)
        addSubview(shareCounterLabel)
        
        shareImageView.tintColor = .gray
        
        shareCounterLabel.textColor = .lightGray
        shareCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        updateShareCounter()
        
        shareImageView.translatesAutoresizingMaskIntoConstraints = false
        shareImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        shareImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        shareImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        shareCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        shareCounterLabel.leadingAnchor.constraint(equalTo: shareImageView.trailingAnchor, constant: 4).isActive = true
        shareCounterLabel.centerYAnchor.constraint(equalTo: shareImageView.centerYAnchor).isActive = true
    }
    
    func updateShareCounter() {
        shareCounterLabel.text = "\(shareCounter)"
    }
}
