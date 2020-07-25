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

    private let topSeparator = UIView()
    let postAuthorImage = UIImageView()
    let postAuthor = UILabel()
    let publishDate = UILabel()
    private let moreButton = UIButton()
    let postText = UILabel()
    var postImageView = UIImageView()
    let postStatistics = PostStatistics()

    var postImageViewHeightConstraint: NSLayoutConstraint!
        
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
        
        postAuthor.text = ""
        postAuthor.textColor = .black
        postAuthor.font = .systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        
        publishDate.text = ""
        publishDate.textColor = Constants.Colors.vkDarkGray
        publishDate.font = .systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        
        moreButton.setImage(.moreButton, for: .normal)
        
        postText.numberOfLines = 0
        
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        
        addSubview(topSeparator)
        addSubview(postAuthorImage)
        addSubview(postAuthor)
        addSubview(publishDate)
        addSubview(moreButton)
        addSubview(postText)
        addSubview(postImageView)
        addSubview(postStatistics)
        
        configureConstraints()
    }
    
//    func configure(with post: Post) {
//        if post.sourceId > 0 {
//            let user = post
//        }
//    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        postAuthorImage.translatesAutoresizingMaskIntoConstraints = false
        postAuthor.translatesAutoresizingMaskIntoConstraints = false
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        postText.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postStatistics.translatesAutoresizingMaskIntoConstraints = false

        postImageViewHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 288)
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 10),
            
            postAuthorImage.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 8),
            postAuthorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postAuthorImage.heightAnchor.constraint(equalToConstant: 48),
            postAuthorImage.widthAnchor.constraint(equalToConstant: 48),
            
            postAuthor.centerYAnchor.constraint(equalTo: postAuthorImage.centerYAnchor, constant: -8),
            postAuthor.leadingAnchor.constraint(equalTo: postAuthorImage.trailingAnchor, constant: 8),
            postAuthor.trailingAnchor.constraint(lessThanOrEqualTo: moreButton.leadingAnchor, constant: -8),
            
            publishDate.leadingAnchor.constraint(equalTo: postAuthor.leadingAnchor),
            publishDate.trailingAnchor.constraint(equalTo: postAuthor.trailingAnchor),
            publishDate.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 2),
            
            moreButton.centerYAnchor.constraint(equalTo: postAuthor.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            postText.topAnchor.constraint(equalTo: postAuthorImage.bottomAnchor, constant: 8),
            postText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            postText.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postStatistics.topAnchor),
            postImageViewHeightConstraint,
            
            postStatistics.leadingAnchor.constraint(equalTo: leadingAnchor),
            postStatistics.trailingAnchor.constraint(equalTo: trailingAnchor),
            {
                let c = postStatistics.bottomAnchor.constraint(equalTo: bottomAnchor)
                c.priority = .defaultHigh
                return c
            }(),
            postStatistics.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
