//
//  PostCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Nuke

class PostCell: UITableViewCell {
    
    static let reuseId = "PostCell"
    
    // MARK: - Private Properties
    
    private let topSeparator = UIView()
    private let postAuthorImage = UIImageView()
    private let postAuthor = UILabel()
    private let publishDate = UILabel()
    private let moreButton = UIButton()
    private let postText = UILabel()
    private var postImageView = UIImageView()
    private let postStatistics = PostStatistics()
    
    private var postImageViewHeightConstraint: NSLayoutConstraint!
    
    private let agoWord = NSLocalizedString("ago", comment: "")
        
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - CellForRowAt configuration
    
    func configure(with post: Post, author: Response?) {
        if let sourceId = post.sourceId {
            if sourceId > 0 {
                let user = author?.profiles.first(where: { $0.id == abs(sourceId) })
                postAuthor.text = user?.name
                Nuke.loadImage(with: URL(string: user?.imageUrl ?? ""), into: postAuthorImage)
            } else {
                let community = author?.groups.first(where: { $0.id == abs(sourceId) })
                postAuthor.text = community?.name
                Nuke.loadImage(with: URL(string: community?.imageUrl ?? ""), into: postAuthorImage)
            }
        } else if let ownerId = post.ownerId {
            if ownerId > 0 {
                let user = author?.profiles.first(where: { $0.id == abs(ownerId) })
                postAuthor.text = user?.name
                Nuke.loadImage(with: URL(string: user?.imageUrl ?? ""), into: postAuthorImage)
            } else {
                let community = author?.groups.first(where: { $0.id == abs(ownerId) })
                postAuthor.text = community?.name
                Nuke.loadImage(with: URL(string: community?.imageUrl ?? ""), into: postAuthorImage)
            }
        }
        
        
        let date = Date(timeIntervalSince1970: post.date).getElapsedInterval()
        publishDate.text = "\(date) \(agoWord)"
        postText.text = post.text
        
        if let attachments = post.attachments {
            if attachments[0].type.contains("photo") || attachments[0].type.contains("post") {
                postImageViewHeightConstraint.constant = 288
                layoutIfNeeded()
                Nuke.loadImage(with: URL(string: attachments[0].photo?.highResPhoto ?? ""), into: postImageView)
            } else {
                postImageView.image = nil
                postImageViewHeightConstraint.constant = 0
                layoutIfNeeded()
            }
        }
        
        //        if post.photos != nil {
        //            if let photoUrl = URL(string: post.photos?[0].highResPhoto ?? "") {
        //                postImageView.kf.indicatorType = .activity
        //                postImageView.kf.setImage(with: photoUrl)
        //            }
        //        }
        
        postStatistics.updateControls(likes: post.likes ?? 0, comments: post.comments ?? 0, reposts: post.reposts ?? 0, views: post.views ?? 0)
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = Constants.Colors.theme
        
        topSeparator.backgroundColor = Constants.Colors.newsSeparator
        
        postAuthorImage.layer.cornerRadius = 24
        postAuthorImage.clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            postAuthor.textColor = .label
        } else {
            postAuthor.textColor = .black
        }
        postAuthor.font = .systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        postAuthor.backgroundColor = Constants.Colors.theme
        
        publishDate.textColor = Constants.Colors.vkGray
        publishDate.backgroundColor = Constants.Colors.theme
        publishDate.font = .systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        
        moreButton.setImage(.moreButton, for: .normal)
        
        postText.numberOfLines = 0
        postText.backgroundColor = Constants.Colors.theme
        
        postImageView.contentMode = .scaleAspectFit

        
        contentView.addSubview(topSeparator)
        contentView.addSubview(postAuthorImage)
        contentView.addSubview(postAuthor)
        contentView.addSubview(publishDate)
        contentView.addSubview(moreButton)
        contentView.addSubview(postText)
        contentView.addSubview(postImageView)
        contentView.addSubview(postStatistics)
        
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
        postStatistics.translatesAutoresizingMaskIntoConstraints = false
        
        postImageViewHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 288)
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 10),
            
            postAuthorImage.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 8),
            postAuthorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
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
            postText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postStatistics.topAnchor),
            postImageViewHeightConstraint,
            
            postStatistics.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postStatistics.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            {
                let c = postStatistics.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                c.priority = .defaultHigh
                return c
            }(),
            postStatistics.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
