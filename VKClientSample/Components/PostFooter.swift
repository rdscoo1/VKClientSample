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
    
//    init(likes: Int, comments: Int, shares: Int, views: Int) {
//        <#statements#>
//    }
    
    private func configureControls() {
        
    }
    
    
    private func setupUI() {
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        
        likeControl.contentMode = .center
        shareControl.contentMode = .center
        commentCotrol.contentMode = .center
        
        [likeControl, commentCotrol, shareControl, viewsConterView].forEach {
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
