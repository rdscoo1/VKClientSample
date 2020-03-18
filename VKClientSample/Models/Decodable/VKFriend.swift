//
//  VKFriend.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

enum VKSex {
    case male, female, none
}

struct VKFriend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case city
    }
}

extension VKFriend {
    struct City: Decodable {
        let title: String
    }
}


