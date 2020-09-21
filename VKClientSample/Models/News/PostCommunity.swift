//
//  PostCommunity.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers class PostCommunity: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var imageUrl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_50"
    }
}
