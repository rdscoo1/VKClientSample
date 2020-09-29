//
//  User.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

struct UserResponse: Decodable {
    let response: [User]?
    let error: VKError?
}

@objcMembers class User: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var status: String? = nil
    dynamic var imageUrl: String? = nil
    
    var name: String { return "\(lastName) \(firstName)" }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case status
        case imageUrl = "photo_100"
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}
