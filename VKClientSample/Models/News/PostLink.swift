//
//  PostLink.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers
class PostLink: Object, Decodable {
    dynamic var url: String = ""
    dynamic var title: String = ""
    dynamic var descript: String? = nil
    dynamic var caption: String? = nil
    dynamic var photo: Photo?

    enum CodingKeys: String, CodingKey {
        case url
        case title
        case descript = "description"
        case caption
        case photo
    }
}
