//
//  PhotoPreviewFooter.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PhotoPreviewFooter: UIView {

    let likeControl = LikeControl()
    let commentImageView = UIImageView(image: .commentButton)
    let shareImageView = UIImageView(image: .shareButton)
    let containerStackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        
        [likeControl, commentImageView, shareImageView].forEach {
            containerStackView.addArrangedSubview($0)
        }
        addSubview(containerStackView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        
        likeControl.contentMode = .center
        commentImageView.contentMode = .center
        shareImageView.contentMode = .center
        
        commentImageView.tintColor = .gray
        shareImageView.tintColor = .gray
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
