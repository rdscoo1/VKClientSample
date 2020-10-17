//
//  Constants.swift
//  LoginApp
//
//  Created by Roman Khodukin on 27.10.2019.
//  Copyright © 2019 Roman Khodukin. All rights reserved.
//

import UIKit

struct Constants {
    enum Colors {
        static let vkBlue = UIColor(hex: "#408bdb")
        
        static var vkGray: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    // Return one of two colors depending on light or dark mode
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#e1e3e6") :
                        UIColor(hex: "#848b96")
                }
            } else {
                // Same old color used for iOS 12 and earlier
                return UIColor(hex: "#848b96")
            }
        }
        
        static var vkGrayWithAlpha: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#e1e3e6", alpha: 0.5) :
                        UIColor(hex: "#848b96", alpha: 0.5)
                }
            } else {
                return UIColor(hex: "#848b96", alpha: 0.5)
            }
        }
        
        
        static var blueButton: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#929599") :
                        UIColor(hex: "#408bdb")
                }
            } else {
                return UIColor(hex: "#408bdb")
            }
        }
        
        static var theme: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#19191b") :
                        UIColor(hex: "#ffffff")
                }
            } else {
                return UIColor(hex: "#ffffff")
            }
        }
        
        static var newsSeparator: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#0a0a0a") :
                        UIColor(hex: "#ebecef")
                }
            } else {
                return UIColor(hex: "#ebecef")
            }
        }

        static var loadingIcon: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#5c5e60") :
                        UIColor(hex: "#afb8c1")
                }
            } else {
                return UIColor(hex: "#afb8c1")
            }
        }
        
        static var textField: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(hex: "#363739") :
                        UIColor(hex: "#ebecef")
                }
            } else {
                return UIColor(hex: "#ebecef")
            }
        }
    }
}


