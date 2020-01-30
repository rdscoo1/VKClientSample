//
//  ShadowPhotoView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 24.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ShadowPhotoView: UIView {
    
    @IBInspectable var size: CGFloat = 40
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var image: UIImage = .helen
    
    let friendPhoto = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .clear
        addSubview(friendPhoto)
        configureFriendPhotoView()
        configureShadow()
    }
    
    func configureFriendPhotoView() {
        friendPhoto.layer.cornerRadius = size / 2
        friendPhoto.layer.masksToBounds = true
        friendPhoto.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        friendPhoto.contentMode = .scaleAspectFit
        friendPhoto.image = image
    }
    
    func configureShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
