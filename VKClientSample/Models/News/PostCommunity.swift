//
//  PostCommunity.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct PostCommunity: Decodable {
    let id: Int
    let name: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_50"
    }
}
