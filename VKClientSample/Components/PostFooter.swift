//
//  PostFooter.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 28.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PostFooter: UIView {
    
    let likeControl = LikeControl()
    let commentCotrol = CommentControl()
    let shareControl = RepostControl()
    let viewsControl = ViewsControl()
    let containerStackView = UIStackView()
    
    init(likes: Int) {
        super.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func updateControls(likes: Int, comments: Int, reposts: Int, views: Int) {
        likeControl.updateLikeControl(quantity: likes)
        commentCotrol.updateCommentControl(quantity: comments)
        shareControl.updateRepostControl(quantity: reposts)
        viewsControl.updateViewsControl(quantity: views)
    }
    
    
    private func setupUI() {
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        
        likeControl.contentMode = .center
        shareControl.contentMode = .center
        commentCotrol.contentMode = .center
        
        [likeControl, commentCotrol, shareControl, viewsControl].forEach {
            containerStackView.addArrangedSubview($0)
        }
        addSubview(containerStackView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.leftAnchor.constraint(equalTo: leftAnchor),
            containerStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            containerStackView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
