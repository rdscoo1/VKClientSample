//
//  StoriesCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 29.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {

    let storyContainerView = UIView()
    let storyImageView = UIImageView(image: .helen)
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
    }
    
    private func setupUI() {
        storyImageView.layer.cornerRadius = 32
        storyImageView.clipsToBounds = true
        
        storyAuthor.text = "Alisa Fatianova"
        storyAuthor.textAlignment = .center
        storyAuthor.numberOfLines = 0
        
        storyContainerView.layer.cornerRadius = 36
        storyContainerView.clipsToBounds = true
        storyContainerView.backgroundColor = .white
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

class StoriesCell: UITableViewCell {
    
    let topSeparator = UIView()
    let containerView = UIView()
    var storiesCollectionView: UICollectionView!
    var items: [Friend] = Friend.friends
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 96)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    static let reuseId = "StoriesCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        topSeparator.backgroundColor = .lightGray
        topSeparator.alpha = 0.3
        
        containerView.addSubview(storiesCollectionView)
        addSubview(topSeparator)
        addSubview(containerView)
        
        configureConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        storiesCollectionView.dataSource = self
        storiesCollectionView.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.reuseId)
        storiesCollectionView.backgroundColor = .clear
        storiesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            storiesCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            storiesCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension StoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.reuseId, for: indexPath)
        return cell
    }
}


