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

//MARK: - UI Elements
    
    private let topSeparator = UIView()
    private let postAuthorImage = UIImageView()
    private let postAuthor = UILabel()
    private let publishDate = UILabel()
    private let moreButton = UIButton()
    private let postText = UILabel()
    private var postImageView = UIImageView()
    private let postLinkView = PostLinkView()
    private let postStatistics = PostStatistics()

    private var postImageViewHeightConstraint: NSLayoutConstraint!
    
    var dateTextCache: [String: Int] = [:]
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
   
//MARK: - CellForRowAt configuration
    
    func configure(with post: Post, author: PostResponse.Response?) {
        if post.sourceId > 0 {
            let user = author?.profiles.first(where: { $0.id == abs(post.sourceId) })
            postAuthor.text = user?.getFullName()
            postAuthorImage.kf.setImage(with: URL(string: user?.photo100 ?? ""))
        } else {
            let community = author?.groups.first(where: { $0.id == abs(post.sourceId) })
            postAuthor.text = community?.name
            postAuthorImage.kf.setImage(with: URL(string: community?.photo50 ?? ""))
        }
        
        let date = Date(timeIntervalSince1970: post.date).getElapsedInterval()
        publishDate.text = "\(date) ago"
        postText.text = post.text
        
        if let attachments = post.attachments {
            if attachments[0].type.contains("photo") || attachments[0].type.contains("post") {
                postImageViewHeightConstraint.constant = 288
                layoutIfNeeded()
                let retry = DelayRetryStrategy(maxRetryCount: 3, retryInterval: .seconds(1))
                postImageView.kf.indicatorType = .activity
                postImageView.kf.setImage(with: URL(string: attachments[0].photo?.highResPhoto ?? ""),
                                                   options: [.retryStrategy(retry)])
            } else {
                postImageView.image = nil
                postImageViewHeightConstraint.constant = 0
                layoutIfNeeded()
            }
        } else if post.photos != nil {
            if let photoUrl = URL(string: post.photos?[0].highResPhoto ?? "") {
                postImageView.kf.indicatorType = .activity
                postImageView.kf.setImage(with: photoUrl)
            }
        }
        
        postStatistics.updateControls(likes: post.likes?.count ?? 0, comments: post.comments.count, reposts: post.reposts.count, views: post.views?.count ?? 0)
    }
    
//MARK: - Setting UI of elements
    
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
        
        postLinkView.layer.cornerRadius = 10
        postLinkView.layer.borderWidth = 1
        postLinkView.layer.borderColor = UIColor.gray.cgColor
        
        addSubview(topSeparator)
        addSubview(postAuthorImage)
        addSubview(postAuthor)
        addSubview(publishDate)
        addSubview(moreButton)
        addSubview(postText)
        addSubview(postImageView)
        addSubview(postLinkView)
        addSubview(postStatistics)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        postAuthorImage.translatesAutoresizingMaskIntoConstraints = false
        postAuthor.translatesAutoresizingMaskIntoConstraints = false
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        postText.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postLinkView.translatesAutoresizingMaskIntoConstraints = false
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
//            postImageView.bottomAnchor.constraint(equalTo: postLinkView.topAnchor),
            postImageViewHeightConstraint,
            
            postLinkView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            postLinkView.bottomAnchor.constraint(equalTo: postStatistics.topAnchor, constant: -4),
            postLinkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            postLinkView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            postLinkView.heightAnchor.constraint(equalToConstant: 144),
            
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
