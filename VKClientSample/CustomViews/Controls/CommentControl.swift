//
//  CommentControl.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CommentControl: UIControl {
    
    let commentImageView = UIImageView(image: .commentButton)
    let commentCounterLabel = UILabel()
    var commentCounter: Int = Int.random(in: 1...1000)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCommentControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCommentControl()
    }
    
    func configureCommentControl() {
        addSubview(commentImageView)
        addSubview(commentCounterLabel)
        
        commentImageView.tintColor = .gray
        
        commentCounterLabel.textColor = .lightGray
        commentCounterLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        updateCommentCounter()
        
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        commentImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        commentImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
        commentCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        commentCounterLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 4).isActive = true
        commentCounterLabel.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor).isActive = true
    }
    
    func updateCommentCounter() {
        commentCounterLabel.text = "\(commentCounter)"
    }
}
