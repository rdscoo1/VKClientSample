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
    
    // Button localisation
    private let toFollowPhrase = NSLocalizedString("Follow", comment: "")
    private let followingPhrase = NSLocalizedString("Following", comment: "")
    
    // Tinted Icons
    private let highlightedCheckmarkIcon = UIImage.followingIcon.tinted(color: Constants.Colors.vkGrayWithAlpha)
    private let highlightedPlusIcon = UIImage.followIcon.tinted(color: Constants.Colors.vkGrayWithAlpha)
    
    private var followState: FollowSwitcher!

    
    // MARK: - Initializers
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerVerticallyWith(padding: 4)
    }
    
    init() {
        super.init(frame: .zero)
        
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = Constants.Colors.vkGray
        
        setTitleColor(Constants.Colors.vkGray, for: .normal)
        setTitleColor(Constants.Colors.vkGrayWithAlpha, for: .highlighted)
        titleLabel?.font = .systemFont(ofSize: 14)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setFollow(state: FollowSwitcher) {
        followState = state
        switch state {
        case .following:
            setTitle(followingPhrase, for: .normal)
            setImage(.followingIcon, for: .normal)
            setImage(highlightedCheckmarkIcon, for: .highlighted)
        case .notFollowing:
            setTitle(toFollowPhrase, for: .normal)
            setImage(.followIcon, for: .normal)
            setImage(highlightedPlusIcon, for: .highlighted)
        }
    }
    
    func changeFollowState(model: Community?) {
        if followState == .following {
            followState = .notFollowing
            setFollow(state: followState)
        } else {
            followState = .following
            setFollow(state: followState)
        }
    }
    
    // MARK: - Private Methods
    

}
