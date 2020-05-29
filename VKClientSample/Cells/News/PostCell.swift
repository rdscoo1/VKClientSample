//
//  PostCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {
    
    static let reuseId = "PostCell"

    let topSeparator = UIView()
    let postAuthorImage = UIImageView()
    let postAuthor = UILabel()
    let publishDate = UILabel()
    let moreButton = UIButton()
    let postText = UILabel()
    let postImageView = UIImageView(image: .postImage)
    let postFooter = PostFooter(likes: 100)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        topSeparator.backgroundColor = .lightGray
        topSeparator.alpha = 0.3
        
        postAuthorImage.layer.cornerRadius = 24
        postAuthorImage.layer.masksToBounds = true
        
        postAuthor.text = "Apple | iPhone | iPad"
        postAuthor.textColor = .black
        postAuthor.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        
        publishDate.text = "вчера в \(Int.random(in: 10...23)):\(Int.random(in: 10...59))"
        publishDate.textColor = Constants.Colors.vkDarkGray
        publishDate.font = .systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        
        moreButton.setImage(.moreButton, for: .normal)
        
        postText.numberOfLines = 0
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        addSubview(topSeparator)
        addSubview(postAuthorImage)
        addSubview(postAuthor)
        addSubview(publishDate)
        addSubview(moreButton)
        addSubview(postText)
        addSubview(postImageView)
        addSubview(postFooter)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        postAuthorImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postAuthorImage.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 8),
            postAuthorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postAuthorImage.heightAnchor.constraint(equalToConstant: 48),
            postAuthorImage.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        postAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postAuthor.centerYAnchor.constraint(equalTo: postAuthorImage.centerYAnchor, constant: -8),
            postAuthor.leadingAnchor.constraint(equalTo: postAuthorImage.trailingAnchor, constant: 8),
            postAuthor.trailingAnchor.constraint(lessThanOrEqualTo: moreButton.leadingAnchor, constant: -8)
        ])
        
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publishDate.leadingAnchor.constraint(equalTo: postAuthor.leadingAnchor),
            publishDate.trailingAnchor.constraint(equalTo: postAuthor.trailingAnchor),
            publishDate.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 2)
        ])
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.centerYAnchor.constraint(equalTo: postAuthor.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        postText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postText.topAnchor.constraint(equalTo: postAuthorImage.bottomAnchor, constant: 16),
            postText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            postText.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postFooter.topAnchor)
        ])
        
        postFooter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postFooter.leadingAnchor.constraint(equalTo: leadingAnchor),
            postFooter.trailingAnchor.constraint(equalTo: trailingAnchor),
            postFooter.bottomAnchor.constraint(equalTo: bottomAnchor),
            postFooter.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
