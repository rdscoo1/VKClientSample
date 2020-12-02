//
//  ActivityIndicatorState.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 11/11/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

enum ActivityIndicatorState: Equatable, CustomStringConvertible {
    
    case initial
    case releasing(progress: CGFloat)
    case loading
    case finished
    
    public var description: String {
        switch self {
        case .initial: return "Inital"
        case .releasing (let progress): return "Releasing:\(progress)"
        case .loading: return "Loading"
        case .finished: return "Finished"
        }
    }
}

func ==(a: ActivityIndicatorState, b: ActivityIndicatorState) -> Bool {
    switch (a, b) {
    case (.initial, .initial): return true
    case (.loading, .loading): return true
    case (.finished, .finished): return true
    case (.releasing, .releasing): return true
    default: return false
    }
}
