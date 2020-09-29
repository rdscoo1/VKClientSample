//
//  RepostControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class RepostControl: UIControl {
    
    private let repostImageView = UIImageView(image: .shareButton)
    private let repostCounterLabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRepostControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureRepostControl()
    }
    
    func updateRepostControl(quantity: Int) {
        if quantity > 0 {
            repostCounterLabel.text = "\(quantity)"
        }
    }
    
    func configureRepostControl() {
        addSubview(repostImageView)
        addSubview(repostCounterLabel)
        
        repostImageView.tintColor = UIColor(hex: "#909399")
        
        repostCounterLabel.textColor = UIColor(hex: "#67707a")
        repostCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
                
        repostImageView.translatesAutoresizingMaskIntoConstraints = false
        repostImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        repostImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        repostImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        repostCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        repostCounterLabel.leadingAnchor.constraint(equalTo: repostImageView.trailingAnchor, constant: 4).isActive = true
        repostCounterLabel.centerYAnchor.constraint(equalTo: repostImageView.centerYAnchor).isActive = true
    }
}
