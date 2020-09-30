//
//  WhatsNewCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 31.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class WhatsNewCell: UITableViewCell {
    
    static let reuseId = "WhatsNewCell"
    
    // MARK: - Private Properties
    
    private let topSeparator = UIView()
    private let whatsNewTF = UITextField()
    private let addPhotoButton = UIButton()
    private let startStreamButton = UIButton()
    
    // MARK: - Public Properties
    
    let profilePhoto = UIImageView()
        
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = Constants.Colors.theme
        
        profilePhoto.layer.cornerRadius = 16
        profilePhoto.layer.masksToBounds = true
        
        topSeparator.backgroundColor = Constants.Colors.newsSeparator
        
        let whatsNewPhrase = NSLocalizedString("What's new?", comment: "")
        let attributes = NSAttributedString(string: whatsNewPhrase,
                                            attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.vkGray,
                                                         NSAttributedString.Key.backgroundColor: Constants.Colors.textField,
                                                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)])
        whatsNewTF.attributedPlaceholder = attributes
        whatsNewTF.backgroundColor = Constants.Colors.textField
        whatsNewTF.layer.cornerRadius = 8
        whatsNewTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        whatsNewTF.leftViewMode = .always
        
        addPhotoButton.setImage(.photoIcon, for: .normal)
        addPhotoButton.tintColor = Constants.Colors.vkGray
        startStreamButton.setImage(.streamIcon, for: .normal)
        startStreamButton.tintColor = Constants.Colors.vkGray
        
        contentView.addSubview(topSeparator)
        contentView.addSubview(profilePhoto)
        contentView.addSubview(whatsNewTF)
        contentView.addSubview(addPhotoButton)
        contentView.addSubview(startStreamButton)
        configureConstraints()
    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhoto.heightAnchor.constraint(equalToConstant: 32),
            profilePhoto.widthAnchor.constraint(equalToConstant: 32),
            profilePhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4),
            profilePhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            profilePhoto.trailingAnchor.constraint(equalTo: whatsNewTF.leadingAnchor, constant: -12)
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
            addPhotoButton.leadingAnchor.constraint(equalTo: whatsNewTF.trailingAnchor, constant: 16),
            addPhotoButton.trailingAnchor.constraint(equalTo: startStreamButton.leadingAnchor, constant: -16)
        ])
        
        startStreamButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startStreamButton.heightAnchor.constraint(equalToConstant: 22),
            startStreamButton.widthAnchor.constraint(equalToConstant: 22),
            startStreamButton.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor),
            startStreamButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
