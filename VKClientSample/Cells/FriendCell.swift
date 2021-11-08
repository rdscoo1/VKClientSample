//
//  FriendsCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    static let reuseId = "FriendCell"
    
    // MARK: - Private Properties
    
    private let friendPhoto = UIImageView()
    private let onlineStatus = UIImageView()
    private let onlineStatusContainer = UIView()
    private let friendFullName = UILabel()
    
    private var onlineContainerHeight: NSLayoutConstraint!
    private var onlineContainerWidth: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Colors.theme
        
        friendPhoto.layer.cornerRadius = 24
        friendPhoto.layer.masksToBounds = true
        
        onlineStatusContainer.alpha = 0.0
        onlineStatusContainer.backgroundColor = Constants.Colors.theme
        onlineStatus.backgroundColor = Constants.Colors.theme
                
        onlineStatusContainer.addSubview(onlineStatus)
        addSubview(friendPhoto)
        addSubview(onlineStatusContainer)
        addSubview(friendFullName)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func configure(with friend: Friend, onlineStatus: OnlineStatusState) {
        friendFullName.text = "\(friend.firstName) \(friend.lastName)"
        if  let photoLink = friend.imageUrl,
            let photoUrl = URL(string: photoLink) {
            friendPhoto.kf.setImage(with: photoUrl)
        }
        setOnlineStatus(onlineStatus)
    }
    
    //MARK: - Private Methods
    
    private func setOnlineStatus(_ status: OnlineStatusState) {
        switch status {
        case .offline:
            onlineStatusContainer.alpha = 0.0
        case .online:
            onlineStatus.image = .online
            onlineContainerHeight.constant = 10
            onlineContainerWidth.constant = 14
            onlineStatusContainer.layer.cornerRadius = 7
            onlineStatus.layer.cornerRadius = 5
            layoutIfNeeded()
            onlineStatusContainer.alpha = 1.0
        case .mobile:
            onlineContainerHeight.constant = 14
            onlineContainerWidth.constant = 12
            onlineStatusContainer.layer.cornerRadius = 4
            layoutIfNeeded()
            onlineStatus.image = .onlineMobile
            onlineStatusContainer.alpha = 1.0
        }
    }
    
    private func configureConstraints() {
        friendPhoto.translatesAutoresizingMaskIntoConstraints = false
        onlineStatusContainer.translatesAutoresizingMaskIntoConstraints = false
        onlineStatus.translatesAutoresizingMaskIntoConstraints = false
        friendFullName.translatesAutoresizingMaskIntoConstraints = false
        
        onlineContainerHeight = onlineStatus.heightAnchor.constraint(equalToConstant: 12)
        onlineContainerWidth = onlineStatusContainer.widthAnchor.constraint(equalToConstant: 12)
        
        NSLayoutConstraint.activate([
            friendPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            friendPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            friendPhoto.widthAnchor.constraint(equalToConstant: 48),
            friendPhoto.heightAnchor.constraint(equalToConstant: 48),
            
            onlineStatusContainer.bottomAnchor.constraint(equalTo: friendPhoto.bottomAnchor),
            onlineStatusContainer.trailingAnchor.constraint(equalTo: friendPhoto.trailingAnchor),
            onlineContainerHeight,
            onlineContainerWidth,
            
            onlineStatus.topAnchor.constraint(equalTo: onlineStatusContainer.topAnchor, constant: 2),
            onlineStatus.trailingAnchor.constraint(equalTo: onlineStatusContainer.trailingAnchor, constant: -2),
            onlineStatus.bottomAnchor.constraint(equalTo: onlineStatusContainer.bottomAnchor, constant: -2),
            onlineStatus.leadingAnchor.constraint(equalTo: onlineStatusContainer.leadingAnchor, constant: 2),
            
            friendFullName.centerYAnchor.constraint(equalTo: friendPhoto.centerYAnchor),
            friendFullName.leadingAnchor.constraint(equalTo: friendPhoto.trailingAnchor, constant: 16),
            friendFullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
