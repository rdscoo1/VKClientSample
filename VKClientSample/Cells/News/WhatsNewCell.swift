//
//  WhatsNewCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 31.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class WhatsNewCell: UITableViewCell {
    
    let topSeparator = UIView()
    let shadowPhotoView = ShadowPhotoView(image: .john, size: 32)
    let whatsNewTF = UITextField()
    let addPhotoButton = UIButton()
    let startStreamButton = UIButton()
    
    static let reuseId = "WhatsNewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
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
        addSubview(shadowPhotoView)
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
        
        shadowPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowPhotoView.heightAnchor.constraint(equalToConstant: 32),
            shadowPhotoView.widthAnchor.constraint(equalToConstant: 32),
            shadowPhotoView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 4),
            shadowPhotoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            shadowPhotoView.rightAnchor.constraint(equalTo: whatsNewTF.leftAnchor, constant: -12)
        ])
        
        whatsNewTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whatsNewTF.heightAnchor.constraint(equalToConstant: 34),
            whatsNewTF.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor)
        ])
        
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.heightAnchor.constraint(equalToConstant: 20),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 20),
            addPhotoButton.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor),
            addPhotoButton.leftAnchor.constraint(equalTo: whatsNewTF.rightAnchor, constant: 16),
            addPhotoButton.rightAnchor.constraint(equalTo: startStreamButton.leftAnchor, constant: -16)
        ])
        
        startStreamButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startStreamButton.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor),
            startStreamButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            startStreamButton.heightAnchor.constraint(equalToConstant: 20),
            startStreamButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        
    }
    
}
