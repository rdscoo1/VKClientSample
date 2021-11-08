//
//  AddStoryPhotoView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 31.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Nuke

class AddStoryPhotoView: UIView {
    
    //MARK: - Private Properties
    
    private let photoImageView = UIImageView()
    private let plusImageViewContainer = UIView()
    private let plusImageView = UIImageView(image: .plusIconToAddStory)
    
    //MARK: - Constants
    
    private let photoSize: CGFloat = 56
    private let plusIconSize: CGFloat = 20
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK: - Public Methods
    
    func setImage(_ url: String?) {
        if let photoUrl = URL(string: url ?? "") {
            Nuke.loadImage(with: photoUrl, into: photoImageView)
        }
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .clear
        
        photoImageView.layer.cornerRadius = photoSize / 2
        photoImageView.layer.masksToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        
        if #available(iOS 13.0, *) {
            plusImageViewContainer.backgroundColor = .systemBackground
        } else {
            plusImageViewContainer.backgroundColor = .white
        }
        plusImageViewContainer.layer.cornerRadius = plusIconSize / 2
        plusImageViewContainer.layer.masksToBounds = true
        
        plusImageView.layer.cornerRadius = plusIconSize / 2 - 1
        plusImageView.layer.masksToBounds = true
        plusImageView.backgroundColor = .white
        plusImageView.tintColor = Constants.Colors.vkBlue
        
        plusImageViewContainer.addSubview(plusImageView)
        addSubview(photoImageView)
        addSubview(plusImageViewContainer)
        configureConstraints()
    }
    
    private func configureConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: photoSize),
            photoImageView.widthAnchor.constraint(equalToConstant: photoSize),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        plusImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusImageViewContainer.heightAnchor.constraint(equalToConstant: plusIconSize),
            plusImageViewContainer.widthAnchor.constraint(equalToConstant: plusIconSize),
            plusImageViewContainer.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),
            plusImageViewContainer.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor)
        ])
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusImageView.heightAnchor.constraint(equalToConstant: plusIconSize - 4),
            plusImageView.widthAnchor.constraint(equalToConstant: plusIconSize - 4),
            plusImageView.centerXAnchor.constraint(equalTo: plusImageViewContainer.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: plusImageViewContainer.centerYAnchor)
        ])
    }
    
}
