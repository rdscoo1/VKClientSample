//
//  AddStoryCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 01.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class AddStoryCell: UICollectionViewCell {
    
    static let reuseId = "AddStoryCell"
    
    //MARK: - Private Properties
    
    private let addStoryPhotoView = AddStoryPhotoView()
    private let storyAuthor = UILabel()
        
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
    
    func configureWith(author: String?, photo: String?) {
        addStoryPhotoView.setImage(photo)
        storyAuthor.text = author
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        storyAuthor.text = "Roman"
        storyAuthor.textAlignment = .center
        storyAuthor.numberOfLines = 0
        storyAuthor.textColor = Constants.Colors.vkGray
        storyAuthor.backgroundColor = Constants.Colors.theme
        storyAuthor.font = .systemFont(ofSize: 12, weight: UIFont.Weight.regular)

        addSubview(addStoryPhotoView)
        addSubview(storyAuthor)
        
        addStoryPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addStoryPhotoView.heightAnchor.constraint(equalToConstant: 64),
            addStoryPhotoView.widthAnchor.constraint(equalToConstant: 64),
            addStoryPhotoView.topAnchor.constraint(equalTo: topAnchor),
            addStoryPhotoView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        storyAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyAuthor.topAnchor.constraint(equalTo: addStoryPhotoView.bottomAnchor, constant: 2),
            storyAuthor.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyAuthor.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyAuthor.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
