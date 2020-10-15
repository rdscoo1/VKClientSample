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
    
    
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setSubscription(state: FollowSwitcher)
    
    // MARK: - Private Methods
    
    private func configureButton() {
//        let icon = UIImage(named: "bmiCalculator")!
//            button.setImage(, for: .normal)
//            button.imageView?.contentMode = .scaleAspectFit
//            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
    }
}
