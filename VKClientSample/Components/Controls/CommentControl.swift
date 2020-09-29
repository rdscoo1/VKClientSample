//
//  CommentControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CommentControl: UIControl {
    
    private let commentImageView = UIImageView(image: .commentButton)
    private let commentCounterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCommentControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCommentControl()
    }
    
    func updateCommentControl(quantity: Int) {
        if quantity > 0 {
            commentCounterLabel.text = "\(quantity)"
        }
    }
    
    func configureCommentControl() {
        addSubview(commentImageView)
        addSubview(commentCounterLabel)
        
        commentImageView.tintColor = UIColor(hex: "#909399")
        
        commentCounterLabel.textColor = UIColor(hex: "#67707a")
        commentCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        commentImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        commentImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        commentCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        commentCounterLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 4).isActive = true
        commentCounterLabel.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor).isActive = true
    }
}
