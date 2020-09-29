//
//  UserDefaults+extensions.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    var isAuthorized: Bool {
        get { return bool(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    var token: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    var userId: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}
