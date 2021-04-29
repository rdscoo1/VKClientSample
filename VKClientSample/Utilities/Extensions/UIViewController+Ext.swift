//
//  UIViewController+Ext.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/18/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainTread(message: String) {
        DispatchQueue.main.async {
            let haptic: HapticFeedback = .success
            let alertVC = AlertViewController(message: message)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
            haptic.impact()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                alertVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func getFollowActionSheet(unfollowHandler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionDelete = UIAlertAction(title: "Отписаться", style: .destructive, handler: unfollowHandler)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        actionDelete.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(actionDelete)
        alertController.addAction(actionCancel)
        alertController.view.tintColor = Constants.Colors.vkBlue
        
        alertController.pruneNegativeWidthConstraints()
        return alertController
    }
}
