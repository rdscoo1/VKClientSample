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
}
