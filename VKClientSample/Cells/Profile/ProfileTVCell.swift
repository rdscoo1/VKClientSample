//
//  ProfileTVCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 26.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import SnapKit

class ProfileTVCell: UITableViewCell {
    static let reuseId = "ProfileTVCell"

    private let avatarImageView = UIImageView()
    private let avatarSize: CGFloat = 80
    
    private let name = UILabel()
    private let status = UILabel()
    private let online = UILabel()
    private let onlineImageView = UIImageView()
    
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
    
    private func configureUI() {
        avatarImageView.layer.cornerRadius = avatarSize / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.image = .helen
        avatarImageView.contentMode = .scaleAspectFill

        name.font = .systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        
        status.font = .systemFont(ofSize: 16)
        
        online.text = "online"
        online.font = .systemFont(ofSize: 15)
        online.textColor = Constants.Colors.vkDarkGray
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
    
    func configure(with name: String, status: String, online: Bool) {
        self.name.text = "\(name)"
        self.status.text = "\(status)"
    }
    
}
