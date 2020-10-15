//
//  CommunityCoverImages.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

class CommunityCoverImages: Object, Decodable {
    @objc dynamic var url: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
}
