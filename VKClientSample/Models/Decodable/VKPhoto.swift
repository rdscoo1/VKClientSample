//
//  VKPhoto.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 22.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

protocol VKPhotoProtocol {
    var sizes: [VKPhoto.Size] { get }
}

struct VKPhoto: Decodable, VKPhotoProtocol {
    let id: Int
    let albumId: Int
    let date: Int
    let ownerId: Int
    let postId: Int?
    let sizes: [Size]
    let text: String

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

extension VKPhoto {
    struct Size: Decodable {
        let height: Int
        let width: Int
        let type: String
        let url: String
    }
}
