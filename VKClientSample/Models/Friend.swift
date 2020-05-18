//
//  Friend.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct Friend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int
    let city: City?
    let photo50: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case city
        case photo50 = "photo_50"
    }
}

extension Friend {
    struct City: Decodable {
        let title: String?
    }
}

struct FriendSection {
    var firstLetter: String
    var items: [Friend]
}


