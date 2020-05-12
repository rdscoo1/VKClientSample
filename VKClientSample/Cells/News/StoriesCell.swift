//
//  StoriesCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 29.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class StoriesCell: UITableViewCell {
    
    let topSeparator = UIView()
    let containerView = UIView()
    var storiesCollectionView: UICollectionView!
    var items: [Friend] = Friend.friends
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 68, height: 84)
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
        storiesCollectionView.register(AddStoryCell.self, forCellWithReuseIdentifier: AddStoryCell.reuseId)
        storiesCollectionView.backgroundColor = .clear
        storiesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 10)
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
        if indexPath.item == 0 {
            guard let addStoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddStoryCell.reuseId, for: indexPath) as? AddStoryCell else {
                return UICollectionViewCell()
            }
            return addStoryCell
        } else {
            guard let storiesCell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.reuseId, for: indexPath) as? StoryCell else {
                return UICollectionViewCell()
            }
            let story = items[indexPath.row]
            storiesCell.setStories(story: story)
            return storiesCell
        }

    }
}


