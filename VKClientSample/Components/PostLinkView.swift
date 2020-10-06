//
//  PostLinkView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/4/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PostLinkView: UIView {
    
    //MARK: - Private Properties
    
    private let linkPhoto = UIImageView(image: .anya)
    private let linkTitle = UILabel()
    private let linkCaption = UILabel()
    
    //MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        
        addSubview(linkPhoto)
        addSubview(linkTitle)
        addSubview(linkCaption)
        
        configureConstraints()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func setPostLinkView(image: UIImage, title: String, caption: String) {
        linkPhoto.image = image
        linkTitle.text = title
        linkCaption.text = caption
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        linkTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        linkTitle.text = "Hellloooowoeowoewowoeowwe"
        linkCaption.text = "yandex.ru"
        
        linkCaption.textColor = .gray
        linkCaption.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func configureConstraints() {
        linkPhoto.translatesAutoresizingMaskIntoConstraints = false
        linkTitle.translatesAutoresizingMaskIntoConstraints = false
        linkCaption.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            linkPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            linkPhoto.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkPhoto.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkPhoto.heightAnchor.constraint(equalToConstant: 144),
            
            linkTitle.topAnchor.constraint(equalTo: linkPhoto.bottomAnchor, constant: 4),
            linkTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            linkTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            linkCaption.topAnchor.constraint(equalTo: linkTitle.bottomAnchor, constant: 4),
            linkCaption.leadingAnchor.constraint(equalTo: linkTitle.leadingAnchor),
            linkCaption.trailingAnchor.constraint(equalTo: linkTitle.trailingAnchor)
        ])
    }
}
