//
//  Photo.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 22.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers class Photo: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var albumId: Int = 0
    dynamic var date: Int = 0
    dynamic var ownerId: Int = 0
    var postId = RealmOptional<Int>()
    var sizes = List<Size>()
    dynamic var text: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case date
        case ownerId = "owner_id"
        case postId = "post_id"
        case sizes
        case text
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        date = try container.decode(Int.self, forKey: .date)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        postId.value = try container.decodeIfPresent(Int.self, forKey: .postId)
        sizes = try container.decode(List<Size>.self, forKey: .sizes)
        text = try container.decode(String.self, forKey: .text)
    }
}

@objcMembers class Size: Object, Decodable {
    dynamic var height: Int = 0
    dynamic var width: Int = 0
    dynamic var type: String = ""
    dynamic var url: String = ""
}
