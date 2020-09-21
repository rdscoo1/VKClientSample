//
//  PostLink.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

class PostLink: Object, Decodable {
    @objc dynamic var url: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descript: String? = nil
    @objc dynamic var caption: String? = nil
    @objc dynamic var photo: Photo?

    enum CodingKeys: String, CodingKey {
        case url
        case title
        case descript = "description"
        case caption
        case photo
    }
}
