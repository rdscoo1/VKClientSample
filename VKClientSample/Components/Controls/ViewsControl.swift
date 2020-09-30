//
//  ViewsCounter.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ViewsControl: UIView {
    
    private let viewIcon = UIImageView(image: .eye)
    private let viewCounterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func updateViewsControl(quantity: Int) {
        if quantity > 0 {
            viewCounterLabel.text = "\(quantity)"
        }
    }
    
    private func setupUI() {
        viewIcon.tintColor = Constants.Colors.vkGray
        
        viewCounterLabel.textColor = Constants.Colors.vkGray
        viewCounterLabel.backgroundColor = Constants.Colors.theme
        viewCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        addSubview(viewIcon)
        addSubview(viewCounterLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        viewIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        viewCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewCounterLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 4),
            viewCounterLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    

}
