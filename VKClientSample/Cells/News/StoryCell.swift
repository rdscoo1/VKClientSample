//
//  StoryCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 01.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher

class StoryCell: UICollectionViewCell {
    
    static let reuseId = "StoryCell"
    
    // MARK: - Private Properties
    
    private let storyContainerView = UIView()
    
    // MARK: - Public Properties
    
    let storyImageView = UIImageView()
    let storyAuthor = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK: - Public Methods
    
    func configure(with model: StoriesCommunity?) {
        storyAuthor.text = model?.name
        storyImageView.kf.setImage(with: URL(string: model?.imageUrl ?? ""))
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        storyImageView.layer.cornerRadius = 28
        storyImageView.clipsToBounds = true
        storyImageView.contentMode = .scaleAspectFill
        
        storyAuthor.textAlignment = .center
        storyAuthor.numberOfLines = 0
        storyAuthor.textColor = Constants.Colors.vkBlue
        storyAuthor.backgroundColor = Constants.Colors.theme
        storyAuthor.font = .systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        
        storyContainerView.layer.cornerRadius = 32
        storyContainerView.clipsToBounds = true
        storyContainerView.backgroundColor = .clear
        storyContainerView.layer.borderWidth = 2
        storyContainerView.layer.borderColor = Constants.Colors.vkBlue.cgColor
        
        storyContainerView.addSubview(storyImageView)
        addSubview(storyContainerView)
        addSubview(storyAuthor)
        configureConstraints()
    }
    
    private func configureConstraints() {
        storyContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyContainerView.heightAnchor.constraint(equalToConstant: 64),
            storyContainerView.widthAnchor.constraint(equalToConstant: 64),
            storyContainerView.topAnchor.constraint(equalTo: topAnchor),
            storyContainerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyImageView.heightAnchor.constraint(equalToConstant: 56),
            storyImageView.widthAnchor.constraint(equalToConstant: 56),
            storyImageView.centerYAnchor.constraint(equalTo: storyContainerView.centerYAnchor),
            storyImageView.centerXAnchor.constraint(equalTo: storyContainerView.centerXAnchor)
        ])
        
        storyAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyAuthor.topAnchor.constraint(equalTo: storyContainerView.bottomAnchor, constant: 2),
            storyAuthor.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyAuthor.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyAuthor.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
