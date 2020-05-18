//
//  Community.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

struct Community: Decodable {
        let id: Int
        let name: String
        let activity: String?
        let photo50: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case activity
            case photo50 = "photo_50"
        }
}

class RealmCommunity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var activity: String = ""
    @objc dynamic var photo50: String = ""
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}

extension RealmCommunity {
    func saveToRealm() {
        let community = RealmCommunity()
        community.id = id
        community.name = name
        community.activity = activity
        community.photo50 = photo50
        RealmService.manager.saveObject(community)
    }
    
    func getModel() -> Community {
        return Community(id: id, name: name, activity: activity, photo50: photo50)
    }
}


