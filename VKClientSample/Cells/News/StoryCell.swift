//
//  StoryCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 01.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    let storyContainerView = UIView()
    let storyImageView = UIImageView()
    let storyAuthor = UILabel()
    
    static let reuseId = "StoryCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setStories(story: Friend) {
        storyImageView.image = UIImage(imageLiteralResourceName: story.avatar)
        storyAuthor.text = "\(story.name) \(story.surname)"
    }
    
    private func setupUI() {
        storyImageView.layer.cornerRadius = 32
        storyImageView.clipsToBounds = true
        storyImageView.contentMode = .scaleAspectFill
        
        storyAuthor.textAlignment = .center
        storyAuthor.numberOfLines = 0
        storyAuthor.textColor = Constants.Colors.vkTheme
        
        storyContainerView.layer.cornerRadius = 36
        storyContainerView.clipsToBounds = true
        storyContainerView.backgroundColor = .clear
        storyContainerView.layer.borderWidth = 2
        storyContainerView.layer.borderColor = Constants.Colors.vkTheme.cgColor
        
        storyContainerView.addSubview(storyImageView)
        addSubview(storyContainerView)
        addSubview(storyAuthor)
        configureConstraints()
    }
    
    private func configureConstraints() {
        storyContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyContainerView.heightAnchor.constraint(equalToConstant: 72),
            storyContainerView.widthAnchor.constraint(equalToConstant: 72),
            storyContainerView.topAnchor.constraint(equalTo: topAnchor),
            storyContainerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyImageView.heightAnchor.constraint(equalToConstant: 64),
            storyImageView.widthAnchor.constraint(equalToConstant: 64),
            storyImageView.centerYAnchor.constraint(equalTo: storyContainerView.centerYAnchor),
            storyImageView.centerXAnchor.constraint(equalTo: storyContainerView.centerXAnchor)
        ])
        
        storyAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyAuthor.topAnchor.constraint(equalTo: storyContainerView.bottomAnchor, constant: 8),
            storyAuthor.rightAnchor.constraint(equalTo: rightAnchor),
            storyAuthor.leftAnchor.constraint(equalTo: leftAnchor),
            storyAuthor.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
