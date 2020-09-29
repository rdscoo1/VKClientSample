//
//  PostPhoto.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers 
class PostPhoto: Object, Decodable {
    dynamic var id: Int = 0
    var sizes = List<PostPhotoSize>()
    dynamic var highResPhoto: String {
        guard let photoLinkhighRes = sizes.first(where: { $0.type == "x" })?.url else {
            return ""
        }
        return photoLinkhighRes
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
}
