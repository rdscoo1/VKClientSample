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
    let shadowPhotoView = ShadowPhotoView(image: .john)
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
        
        let attributes = NSAttributedString(string: "What's new?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
        whatsNewTF.attributedPlaceholder = attributes
        whatsNewTF.backgroundColor = .lightGray
        whatsNewTF.alpha = 0.2
        whatsNewTF.layer.cornerRadius = 8
        whatsNewTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: self.frame.height))
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
            topSeparator.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        shadowPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowPhotoView.heightAnchor.constraint(equalToConstant: 32),
            shadowPhotoView.widthAnchor.constraint(equalToConstant: 32),
            shadowPhotoView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 8),
            shadowPhotoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            shadowPhotoView.rightAnchor.constraint(equalTo: whatsNewTF.leftAnchor, constant: -16)
        ])
        
        whatsNewTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whatsNewTF.heightAnchor.constraint(equalToConstant: 32),
            whatsNewTF.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor, constant: 4)
        ])
        
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.heightAnchor.constraint(equalToConstant: 24),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 24),
            addPhotoButton.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor, constant: 4),
            addPhotoButton.leftAnchor.constraint(equalTo: whatsNewTF.rightAnchor, constant: 8),
            addPhotoButton.rightAnchor.constraint(equalTo: startStreamButton.leftAnchor, constant: -8)
        ])
        
        startStreamButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startStreamButton.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor, constant: 4),
            startStreamButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            startStreamButton.heightAnchor.constraint(equalToConstant: 24),
            startStreamButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        
    }
    
}
