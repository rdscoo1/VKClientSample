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
    
    static let reuseId = "StoryCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        storyImageView.layer.cornerRadius = 32
        storyImageView.clipsToBounds = true
        
        storyContainerView.layer.cornerRadius = 36
        storyContainerView.clipsToBounds = true
        storyContainerView.backgroundColor = .white
        storyContainerView.layer.borderWidth = 2
        storyContainerView.layer.borderColor = Constants.Colors.vkTheme.cgColor
        
        storyContainerView.addSubview(storyImageView)
        addSubview(storyContainerView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        storyContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyContainerView.heightAnchor.constraint(equalToConstant: 72),
            storyContainerView.widthAnchor.constraint(equalToConstant: 72),
            storyContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            storyContainerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyImageView.heightAnchor.constraint(equalToConstant: 64),
            storyImageView.widthAnchor.constraint(equalToConstant: 64),
            storyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            storyImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
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
        layout.itemSize = CGSize(width: 110, height: 130)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    static let reuseId = "StoriesCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
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
            storiesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            storiesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            storiesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
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


