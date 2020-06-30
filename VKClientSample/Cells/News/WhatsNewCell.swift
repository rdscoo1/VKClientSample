//
//  WhatsNewCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 31.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class WhatsNewCell: UITableViewCell {
    
    private let topSeparator = UIView()
    let profilePhoto = UIImageView()
    private let whatsNewTF = UITextField()
    private let addPhotoButton = UIButton()
    private let startStreamButton = UIButton()
    
    static let reuseId = "WhatsNewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        profilePhoto.layer.cornerRadius = 16
        profilePhoto.layer.masksToBounds = true
        
        topSeparator.backgroundColor = .lightGray
        topSeparator.alpha = 0.3
        
        let attributes = NSAttributedString(string: "What's new?",
                                            attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.vkDarkGray,
                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)])
        whatsNewTF.attributedPlaceholder = attributes
        whatsNewTF.backgroundColor = Constants.Colors.vkLightGray
        whatsNewTF.layer.cornerRadius = 8
        whatsNewTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        whatsNewTF.leftViewMode = .always
        
        addPhotoButton.setImage(.photoIcon, for: .normal)
        addPhotoButton.tintColor = .lightGray
        startStreamButton.setImage(.streamIcon, for: .normal)
        startStreamButton.tintColor = .lightGray
        
        addSubview(topSeparator)
        addSubview(profilePhoto)
        addSubview(whatsNewTF)
        addSubview(addPhotoButton)
        addSubview(startStreamButton)
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
        
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhoto.heightAnchor.constraint(equalToConstant: 32),
            profilePhoto.widthAnchor.constraint(equalToConstant: 32),
            profilePhoto.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 4),
            profilePhoto.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            profilePhoto.rightAnchor.constraint(equalTo: whatsNewTF.leftAnchor, constant: -12)
        ])
        
        whatsNewTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whatsNewTF.heightAnchor.constraint(equalToConstant: 34),
            whatsNewTF.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor)
        ])
        
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.heightAnchor.constraint(equalToConstant: 22),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 22),
            addPhotoButton.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor),
            addPhotoButton.leftAnchor.constraint(equalTo: whatsNewTF.rightAnchor, constant: 16),
            addPhotoButton.rightAnchor.constraint(equalTo: startStreamButton.leftAnchor, constant: -16)
        ])
        
        startStreamButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startStreamButton.heightAnchor.constraint(equalToConstant: 22),
            startStreamButton.widthAnchor.constraint(equalToConstant: 22),
            startStreamButton.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor),
            startStreamButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
        
        
    }
    
}
