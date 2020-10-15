//
//  FollowButton.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FollowButton: UIButton {
    
    // MARK: - Private Properties
    
    private let toFollowPhrase = NSLocalizedString("Follow", comment: "")
    private let followingPhrase = NSLocalizedString("Following", comment: "")
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 8, left: -128, bottom: 8, right: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setFollow(state: FollowSwitcher) {
        switch state {
        case .following:
            setTitle(followingPhrase, for: .normal)
            backgroundColor = UIColor.clear
            layer.borderWidth = 1
            layer.borderColor = Constants.Colors.vkGray.cgColor
            setTitleColor(Constants.Colors.vkGray, for: .normal)
            setImage(.checkmarkIcon, for: .normal)
            imageView?.tintColor = Constants.Colors.vkGray
        case .notFollowing:
            setTitle(toFollowPhrase, for: .normal)
            setTitleColor(Constants.Colors.theme, for: .normal)
            backgroundColor = Constants.Colors.blueButton
            setImage(.plusIcon, for: .normal)
            imageView?.tintColor = Constants.Colors.theme
        }
    }
    
    // MARK: - Private Methods
}
