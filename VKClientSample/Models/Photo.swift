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
    dynamic var highResPhoto: String {
        guard let photoLinkhighRes = sizes.first(where: { $0.type == "x" })?.url else {
            return ""
        }
        return photoLinkhighRes
    }

    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case date
        case ownerId = "owner_id"
        case postId = "post_id"
        case sizes
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        albumId = try container.decode(Int.self, forKey: .albumId)
        date = try container.decode(Int.self, forKey: .date)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        postId.value = try container.decodeIfPresent(Int.self, forKey: .postId)
        sizes = try container.decode(List<Size>.self, forKey: .sizes)
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return [ "albumId", "postId"]
    }
}

@objcMembers class Size: Object, Decodable {
    dynamic var height: Int = 0
    dynamic var width: Int = 0
    dynamic var type: String = ""
    dynamic var url: String = ""
    
    override static func primaryKey() -> String? { // По `url`  при совпадении: перезаписывает, а не дублирует
        return "url"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["height", "width"]
    }
}

extension Photo {
    override var debugDescription: String {
        return "<Photo:\(id)> with url \(highResPhoto)"
    }
}
