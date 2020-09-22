//
//  PostPhotoSize.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers 
class PostPhotoSize: Object, Decodable {
    dynamic var height: Int = 0
    dynamic var width: Int = 0
    dynamic var type: String = ""
    dynamic var url: String = ""
    
    override static func primaryKey() -> String? { // По `url`  при совпадении: перезаписывает, а не дублирует
        return "url"
    }
}
