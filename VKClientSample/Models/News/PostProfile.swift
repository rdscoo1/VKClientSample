//
//  PostProfile.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//
 
struct PostProfile: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let imageUrl: String?
    var name: String { return "\(lastName) \(firstName)" }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "photo_50"
    }
}
