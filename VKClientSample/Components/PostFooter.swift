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
    let shareControl = ShareControl()
    let viewsConterView = ViewsCounter()
    let containerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    private func setupUI() {
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        
        likeControl.contentMode = .center
        shareControl.contentMode = .center
        commentCotrol.contentMode = .center
        
        [likeControl, commentCotrol, shareControl].forEach {
            containerStackView.addArrangedSubview($0)
        }
        addSubview(containerStackView)
        addSubview(viewsConterView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        [likeControl, commentCotrol, shareControl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: containerStackView.centerYAnchor).isActive = true
        }
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            containerStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -112),
            containerStackView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        viewsConterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewsConterView.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewsConterView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            viewsConterView.heightAnchor.constraint(equalToConstant: 32),
            viewsConterView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
}
