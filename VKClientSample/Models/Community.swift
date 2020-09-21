//
//  Community.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers class Community: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var activity: String? = nil
    dynamic var imageUrl: String? = nil
        
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case activity
        case imageUrl = "photo_50"
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}

extension Community {
    override var debugDescription: String {
       return "\n📓<Community with id:\(id)> \(name), which activity is \(String(describing: activity)).📓 His photo url is \(String(describing: imageUrl))"
    }
}
