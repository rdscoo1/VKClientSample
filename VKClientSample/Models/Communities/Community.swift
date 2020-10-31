//
//  Community.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

enum FollowButtonState {
    case following
    case notFollowing
}

@objcMembers class Community: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var activity: String? = nil
    dynamic var imageUrl: String? = nil
    dynamic var status: String? = nil
    dynamic var descript: String? = nil
    dynamic var membersQuantity: Int = 0
    dynamic var isMember: Int = 0
    dynamic var cover: CommunityCover?
    
    var followState: FollowButtonState {
        if isMember == 0 {
            return .notFollowing
        } else {
            return .following
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case activity
        case imageUrl = "photo_200"
        case status
        case descript = "description"
        case membersQuantity = "members_count"
        case isMember = "is_member"
        case cover
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}

extension Community {
    override var debugDescription: String {
        return "\n📓<Community with id:\(id)> \(name) has \(membersQuantity) members.\n📓 It's photo url is \(String(describing: imageUrl)).\nCover: \(String(describing: cover))"
    }
}
