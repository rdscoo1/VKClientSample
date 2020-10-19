//
//  HapticFeedback.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/18/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

public enum HapticFeedback {
    
    case success
    case warning
    case error
    case none
    
    // MARK: - Run vibro-haptic

    func impact() {
        let generator = UINotificationFeedbackGenerator()
        switch self {
        case .success:
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
        case .warning:
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.warning)
        case .error:
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
        case .none:
            break
        }
    }
}
