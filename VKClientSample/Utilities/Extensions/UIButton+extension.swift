//
//  UIButton+extension.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/16/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

extension UIButton {
    
    func centerVerticallyWith(padding: CGFloat) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size
        else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: max(0, -(totalHeight - imageViewSize.height)),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: (totalHeight - imageViewSize.height),
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}
