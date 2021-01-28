//
//  PostStatistics.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PostStatistics: UIView {
    
    //MARK: - Private Properties
    
    private let likeControl = LikeControl()
    private let commentControl = CommentControl()
    private let shareControl = RepostControl()
    private let viewsControl = ViewsControl()
    private let containerStackView = UIStackView()
    
    //MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK: - Public Methods
    
    func updateControls(likes: Int, comments: Int, reposts: Int, views: Int) {
        likeControl.updateLikeControl(quantity: likes)
        commentControl.updateCommentControl(quantity: comments)
        shareControl.updateRepostControl(quantity: reposts)
        viewsControl.updateViewsControl(quantity: views)
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        
        likeControl.contentMode = .center
        shareControl.contentMode = .center
        commentControl.contentMode = .center
        
        [likeControl, commentControl, shareControl].forEach {
            containerStackView.addArrangedSubview($0)
        }
        addSubview(containerStackView)
//        addSubview(viewsControl)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        viewsControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            containerStackView.heightAnchor.constraint(equalToConstant: 32),
            
//            viewsControl.centerYAnchor.constraint(equalTo: centerYAnchor),
//            viewsControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
//            viewsControl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
