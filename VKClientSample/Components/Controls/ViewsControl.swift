//
//  ViewsCounter.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ViewsControl: UIView {
    
    let viewIcon = UIImageView(image: .eye)
    let viewCounterLabel = UILabel()
    
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
        viewCounterLabel.textColor = UIColor(hex: "#67707a")
        viewCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        viewIcon.tintColor = UIColor(hex: "#909399")
        
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
