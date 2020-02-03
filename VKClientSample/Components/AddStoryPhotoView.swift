//
//  AddStoryPhotoView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 31.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class AddStoryPhotoView: UIView {

    let photoImageView = UIImageView(image: .john)
    let plusImageViewContainer = UIView()
    let plusImageView = UIImageView(image: .plusIconToAddStory)
    let photoSize: CGFloat = 64
    let plusIconSize: CGFloat = 20

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        photoImageView.layer.cornerRadius = photoSize / 2
        photoImageView.layer.masksToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        
        plusImageViewContainer.backgroundColor = .white
        plusImageViewContainer.layer.cornerRadius = plusIconSize / 2
        plusImageViewContainer.layer.masksToBounds = true
        
        plusImageView.layer.cornerRadius = plusIconSize / 2 - 1
        plusImageView.layer.masksToBounds = true
        
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
            plusImageViewContainer.rightAnchor.constraint(equalTo: photoImageView.rightAnchor),
            plusImageViewContainer.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor)
        ])
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusImageView.heightAnchor.constraint(equalToConstant: plusIconSize - 2),
            plusImageView.widthAnchor.constraint(equalToConstant: plusIconSize - 2),
            plusImageView.centerXAnchor.constraint(equalTo: plusImageViewContainer.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: plusImageViewContainer.centerYAnchor)
        ])
    }

}