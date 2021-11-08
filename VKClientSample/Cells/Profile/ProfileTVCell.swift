//
//  ProfileTVCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 26.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import SnapKit
import Nuke

class ProfileTVCell: UITableViewCell {
    
    static let reuseId = "ProfileTVCell"

    //MARK: - Private Properties
    
    private let avatarImageView = UIImageView()
    private let name = UILabel()
    private let status = UILabel()
    private let online = UILabel()
    private let onlineImageView = UIImageView()
    
    //MARK: - Constants
    
    private let avatarSize: CGFloat = 80
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(avatarImageView)
        addSubview(name)
        addSubview(status)
        addSubview(online)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Metods
    
    private func configureUI() {
        avatarImageView.layer.cornerRadius = avatarSize / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill

        name.font = .systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        
        status.font = .systemFont(ofSize: 16)
        
        online.text = "online"
        online.font = .systemFont(ofSize: 15)
        online.textColor = Constants.Colors.vkGray
    }
    
    private func setConstraints() {
        avatarImageView.snp.makeConstraints{
            $0.height.width.equalTo(avatarSize)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        
        name.snp.makeConstraints{
            $0.top.equalTo(avatarImageView.snp.top).offset(8)
            $0.left.equalTo(avatarImageView.snp.right).inset(-8)
            $0.right.equalToSuperview().inset(16)
        }
        
        status.snp.makeConstraints{
            $0.top.equalTo(name.snp.bottom).offset(4)
            $0.left.equalTo(name.snp.left)
            $0.right.equalTo(name.snp.right)
        }
        
        online.snp.makeConstraints{
            $0.top.equalTo(status.snp.bottom).offset(4)
            $0.left.equalTo(name.snp.left)
            $0.right.equalTo(name.snp.right)
        }
    }
    
    //MARK: - Public Metods
   
    func configure(user: User) {
        name.text = "\(user.firstName) \(user.lastName)"
        status.text = "\(user.status ?? "")"
        if let imageUrl = URL(string: user.imageUrl ?? "") {
            Nuke.loadImage(with: imageUrl, into: avatarImageView)
        }
    }
    
}
