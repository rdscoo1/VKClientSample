//
//  Stories.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/28/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

struct StoriesResponse: Decodable {
    var response: StoryResponse?
    let error: VKError?
}

struct StoryResponse: Decodable {
    var groups: [StoriesCommunity]?
}

@objcMembers
class StoriesCommunity: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var imageUrl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_100"
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}
