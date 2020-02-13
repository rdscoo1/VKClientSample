//
//  ViewsCounter.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ViewsCounter: UIView {
    
    let viewIcon = UIImageView(image: .eye)
    let viewCounterLabel = UILabel()
    
    var counter: Int = Int.random(in: 1...1000)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        viewCounterLabel.textColor = .lightGray
        viewCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        viewCounterLabel.text = "\(counter)"
        
        viewIcon.tintColor = .lightGray
        
        addSubview(viewIcon)
        addSubview(viewCounterLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        viewIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewIcon.leftAnchor.constraint(equalTo: leftAnchor),
            viewIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        viewCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewCounterLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 4),
            viewCounterLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    

}
