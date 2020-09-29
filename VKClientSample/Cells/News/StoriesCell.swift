//
//  StoriesCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 29.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher

class StoriesCell: UITableViewCell {
    
    static let reuseId = "StoriesCell"
    
    private let vkApi = VKApi()
    private let containerView = UIView()
    private var storiesCollectionView: UICollectionView!
    private var stories: [StoriesCommunity]?
    var userPhoto: String? = ""
    var userName: String? = ""
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 68, height: 84)
        layout.scrollDirection = .horizontal
        return layout
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = Constants.Colors.theme
        
        containerView.addSubview(storiesCollectionView)
        contentView.addSubview(containerView)
        
        vkApi.getStories { stories in
            self.stories = stories.groups
            self.storiesCollectionView.reloadData()
        }
        
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
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
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

extension StoriesCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let addStoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddStoryCell.reuseId, for: indexPath) as? AddStoryCell else {
                return UICollectionViewCell()
            }
            if let photoUrl = URL(string: userPhoto!) {
                addStoryCell.addStoryPhotoView.photoImageView.kf.setImage(with: photoUrl)
            }
            addStoryCell.storyAuthor.text = userName
            
            return addStoryCell
        } else {
            guard let storiesCell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.reuseId, for: indexPath) as? StoryCell else {
                return UICollectionViewCell()
            }
            let story = stories?[indexPath.row]
            storiesCell.storyAuthor.text = story?.name
            storiesCell.storyImageView.kf.setImage(with: URL(string: story?.imageUrl ?? ""))
            return storiesCell
        }
    }
}


