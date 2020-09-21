//
//  PostAttachment.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/22/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

class PostAttachment: Object, Decodable {
    @objc dynamic var type: String = ""
    @objc dynamic var photo: PostPhoto?
}
