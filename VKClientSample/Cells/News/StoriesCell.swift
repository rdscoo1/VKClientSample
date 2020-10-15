//
//  StoriesCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 29.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class StoriesCell: UITableViewCell {
    
    static let reuseId = "StoriesCell"
    
    // MARK: - Private Properties
    
    private let vkApi = VKApi()
    private let containerView = UIView()
    private var storiesCollectionView: UICollectionView!
    private var stories: [StoriesCommunity]?
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 68, height: 84)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    // MARK: - Public Properties
    
    var userPhoto: String? = ""
    var userName: String? = ""

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Constants.Colors.theme
        
        setupCollectionView()
        
        containerView.addSubview(storiesCollectionView)
        contentView.addSubview(containerView)
        
        configureConstraints()
        
        loadFromRealm()
        vkApi.getStories { [weak self] stories in
            self?.stories = stories.groups
            self?.storiesCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func loadFromRealm() {
        let stories = RealmService.manager.getAllObjects(of: StoriesCommunity.self)
        self.stories = stories
        storiesCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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

//MARK: - UICollectionViewDataSource

extension StoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let addStoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddStoryCell.reuseId, for: indexPath) as? AddStoryCell else {
                return UICollectionViewCell()
            }
            
            addStoryCell.configureWith(author: userName, photo: userPhoto)
            
            return addStoryCell
        } else {
            guard let storiesCell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.reuseId, for: indexPath) as? StoryCell else {
                return UICollectionViewCell()
            }
            let story = stories?[indexPath.row]
            
            storiesCell.configure(with: story)
            
            return storiesCell
        }
    }
}


