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
        dynamic var photo50: String = ""
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case activity
            case photo50 = "photo_50"
        }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}
