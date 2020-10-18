//
//  CommunityInfoCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher

class CommunityInfoCell: UITableViewCell {
    
    static let reuseId = "CommunityInfoCell"
    
    // MARK: - Private Properties
    
    private let insetView = UIView()
    private let name = UILabel()
    private let status = UILabel()
    private let photo = UIImageView()
    private let followButton = FollowButton()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with community: Community) {
        name.text = community.name
        
        if community.status == "" {
            status.text = community.activity
        } else {
            status.text = community.status
        }
        
        if let imageUrl = URL(string: community.imageUrl ?? "") {
            photo.kf.setImage(with: imageUrl)
        }
        
        followButton.setFollow(state: community.followState)
    }
    
    func configureFollowButton(with model: Community) {
        followButton.changeFollowState(model: model)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = Constants.Colors.theme
        
        insetView.backgroundColor = Constants.Colors.vkGray
        
        if #available(iOS 13.0, *) {
            name.textColor = .label
        } else {
            name.textColor = .black
        }
        name.font = .systemFont(ofSize: 18, weight: .semibold)
        
        status.textColor = Constants.Colors.vkGray
        
        photo.layer.cornerRadius = 40
        photo.layer.masksToBounds = true
        
        contentView.addSubview(insetView)
        contentView.addSubview(name)
        contentView.addSubview(status)
        contentView.addSubview(photo)
        contentView.addSubview(followButton)
    }
    
    private func configureConstraints() {
        insetView.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        status.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            insetView.heightAnchor.constraint(equalToConstant: 0.2),
            insetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            insetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            insetView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            photo.heightAnchor.constraint(equalToConstant: 80),
            photo.widthAnchor.constraint(equalToConstant: 80),
            photo.centerYAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            name.topAnchor.constraint(equalTo: insetView.topAnchor, constant: 32),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            status.trailingAnchor.constraint(lessThanOrEqualTo: photo.leadingAnchor, constant: -8),
            
            status.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            status.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            status.trailingAnchor.constraint(lessThanOrEqualTo: photo.leadingAnchor, constant: -8),
            
            followButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 160),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            followButton.heightAnchor.constraint(equalToConstant: 120),
            followButton.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 32)
        ])
    }
}