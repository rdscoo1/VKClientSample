//
//  Photo.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 22.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

protocol PhotoProtocol {
    var sizes: [Photo.Size] { get }
}

struct Photo: Decodable, PhotoProtocol {
    var id: Int
    var albumId: Int
    var date: Int
    var ownerId: Int
    var postId: Int?
    var sizes: [Size]
    var text: String

    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case date
        case ownerId = "owner_id"
        case postId = "post_id"
        case sizes
        case text
    }
}

extension Photo {
    struct Size: Decodable {
        var height: Int
        var width: Int
        var type: String
        var url: String
    }
}
