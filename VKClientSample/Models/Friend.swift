//
//  Friend.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers class Friend: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var online: Int = 0
    dynamic var city: City?
    dynamic var photo50: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case city
        case photo50 = "photo_50"
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}

class City: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = nil
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}

struct FriendSection {
    var firstLetter: String
    var items: [Friend]
}


