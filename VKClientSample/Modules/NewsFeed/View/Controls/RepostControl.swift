//
//  RepostControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class RepostControl: UIControl {
    
    //MARK: - Private Properties
    
    private let repostImageView = UIImageView(image: .shareIcon)
    private let repostCounterLabel = UILabel()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRepostControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureRepostControl()
    }
    
    //MARK: - Public Methods
    
    func updateRepostControl(quantity: Int) {
        if quantity > 0 {
            repostCounterLabel.text = "\(quantity)"
        }
    }
    
    //MARK: - Private Methods
    
    private func configureRepostControl() {
        repostImageView.tintColor = Constants.Colors.vkGray
        
        repostCounterLabel.textColor = Constants.Colors.vkGray
        repostCounterLabel.backgroundColor = Constants.Colors.theme
        repostCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        addSubview(repostImageView)
        addSubview(repostCounterLabel)
        
        repostImageView.translatesAutoresizingMaskIntoConstraints = false
        repostImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        repostImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        repostImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        repostCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        repostCounterLabel.leadingAnchor.constraint(equalTo: repostImageView.trailingAnchor, constant: 4).isActive = true
        repostCounterLabel.centerYAnchor.constraint(equalTo: repostImageView.centerYAnchor).isActive = true
    }
}
