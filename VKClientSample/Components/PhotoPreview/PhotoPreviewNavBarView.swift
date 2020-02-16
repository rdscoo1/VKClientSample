//
//  PhotoPreviewNavBarView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 16.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PhotoPreviewNavBarView: UIView {

    let backButton = UIButton()
    let photosQuantityLabel = UILabel()
    let moreButton = UIButton()
    
    init(selectedPhotoNumber: Int, photosQuantity: Int) {
        super.init(frame: .zero)
        
        configureUI()
        setPhotosQuantityLabel(selectedPhotoNumber: selectedPhotoNumber, photosQuantity: photosQuantity)
        
        addSubview(backButton)
        addSubview(photosQuantityLabel)
        addSubview(moreButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPhotosQuantityLabel(selectedPhotoNumber: Int, photosQuantity: Int) {
        photosQuantityLabel.text = "\(selectedPhotoNumber) of \(photosQuantity)"
    }
    
    private func configureUI() {
        backgroundColor = UIColor(hex: "#2E2E2E", alpha: 0.8)
        
        backButton.setImage(.backButton, for: .normal)
        backButton.tintColor = .white
        
        photosQuantityLabel.textColor = .white
        photosQuantityLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        moreButton.setImage(.moreButton, for: .normal)
        moreButton.tintColor = .white
    }
    
    private func setConstraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        photosQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosQuantityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            photosQuantityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.heightAnchor.constraint(equalToConstant: 24),
            moreButton.widthAnchor.constraint(equalToConstant: 24),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

}
