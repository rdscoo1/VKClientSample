//
//  UIAlertController+Ext.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/19/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
