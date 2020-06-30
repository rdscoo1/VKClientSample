//
//  PhotoPreviewFooter.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PhotoPreviewFooter: UIView {

    private let likeControl = LikeControl()
    private let commentControl = CommentControl()
    private let repostControl = RepostControl()
    private let containerStackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        
        [likeControl, commentControl, repostControl].forEach {
            containerStackView.addArrangedSubview($0)
        }
        addSubview(containerStackView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateControls(likes: Int, comments: Int, reposts: Int) {
        likeControl.updateLikeControl(quantity: likes)
        commentControl.updateCommentControl(quantity: comments)
        repostControl.updateRepostControl(quantity: reposts)
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        
        likeControl.contentMode = .center
        commentControl.contentMode = .center
        repostControl.contentMode = .center
        
        commentControl.tintColor = .gray
        repostControl.tintColor = .gray
    }
    
    private func setConstraints() {        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

}
