//
//  ShadowPhotoView.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 24.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ShadowPhotoView: UIView {
    
    //MARK: - IBInspectables
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    //MARK: - Private Properties
    
    private let friendPhoto = UIImageView()
    
    //MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init(image: UIImage, size: CGFloat) {
        super.init(frame: .zero)
        setupUI()
        setImage(image: image)
        configureFriendPhotoView(size: size)
    }
    
    //MARK: - Public Methods
    
    func setImage(image: UIImage) {
        friendPhoto.image = image
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(friendPhoto)
        configureShadow()
        let tap = UITapGestureRecognizer(target: self, action: #selector(shadowPhotoTapped))
        self.addGestureRecognizer(tap)
    }
    
    private func configureFriendPhotoView(size: CGFloat) {
        friendPhoto.layer.cornerRadius = size / 2
        friendPhoto.layer.masksToBounds = true
        friendPhoto.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        friendPhoto.contentMode = .scaleAspectFill
    }
    
    private func configureShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func animateButtonTap() {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: {
                self.friendPhoto.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { (_) in
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.5,
                options: .curveEaseIn,
                animations: {
                    self.friendPhoto.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
        }
    }
    
    @objc private func shadowPhotoTapped() {
        animateButtonTap()
    }
}
