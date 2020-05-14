//
//  VKFriend.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

protocol VKFriendProtocol {
    var id: Int { get }
    var firstName: String { get }
    var lastName: String { get }
    var photo50: String? { get }
}

struct VKFriend: Decodable, VKFriendProtocol {
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

extension VKFriend {
    struct City: Decodable {
        let title: String?
    }
}

extension VKFriend {
    var titleFirstLetter: String {
        return lastName[lastName.startIndex].uppercased()
    }
}


