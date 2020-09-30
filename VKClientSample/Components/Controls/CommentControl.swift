//
//  CommentControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CommentControl: UIControl {
    
    //MARK: - Private Properties
    
    private let commentImageView = UIImageView(image: .commentIcon)
    private let commentCounterLabel = UILabel()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCommentControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCommentControl()
    }
    
    //MARK: - Public Methods
    
    func updateCommentControl(quantity: Int) {
        if quantity > 0 {
            commentCounterLabel.text = "\(quantity)"
        }
    }
    
    //MARK: - Private Methods
    
    private func configureCommentControl() {
        commentImageView.tintColor = Constants.Colors.vkGray
        
        commentCounterLabel.textColor = Constants.Colors.vkGray
        commentCounterLabel.backgroundColor = Constants.Colors.theme
        commentCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        addSubview(commentImageView)
        addSubview(commentCounterLabel)
        
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        commentImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        commentImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        commentCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        commentCounterLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 4).isActive = true
        commentCounterLabel.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor).isActive = true
    }
}
