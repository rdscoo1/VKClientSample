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
    
    private let friendPhoto = UIImageView()
    private let onlineStatus = UIImageView(image: .online)
    private let friendFullName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        friendPhoto.layer.cornerRadius = 24
        friendPhoto.layer.masksToBounds = true
        
        friendPhoto.addSubview(onlineStatus)
        addSubview(friendPhoto)
        addSubview(friendFullName)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        friendPhoto.translatesAutoresizingMaskIntoConstraints = false
        friendFullName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            friendPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            friendPhoto.widthAnchor.constraint(equalToConstant: 48),
            friendPhoto.heightAnchor.constraint(equalToConstant: 48),
            
            onlineStatus.bottomAnchor.constraint(equalTo: friendPhoto.bottomAnchor),
            onlineStatus.trailingAnchor.constraint(equalTo: friendPhoto.trailingAnchor),
            
            friendFullName.centerYAnchor.constraint(equalTo: friendPhoto.centerYAnchor),
            friendFullName.leadingAnchor.constraint(equalTo: friendPhoto.trailingAnchor, constant: 16),
            friendFullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with friend: Friend) {
        friendFullName.text = "\(friend.firstName) \(friend.lastName)"
        if  let photoLink = friend.imageUrl,
            let photoUrl = URL(string: photoLink) {
            friendPhoto.kf.setImage(with: photoUrl)
        }
    }
}
