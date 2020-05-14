//
//  VKCommunity.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

protocol VKCommunityProtocol {
    var id: Int { get }
    var name: String { get }
    var activity: String? { get }
    var photo50: String { get }
}

struct VKCommunity: Decodable, VKCommunityProtocol {
        let id: Int
        let name: String
        let activity: String?
        let isAdmin: Int
        let isAdvertiser: Int
        let isClosed: Int
        let isMember: Int
        let screenName: String
        let type: String
        let photo100: String
        let photo200: String
        let photo50: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case activity
            case isAdmin = "is_admin"
            case isAdvertiser = "is_advertiser"
            case isClosed = "is_closed"
            case isMember = "is_member"
            case screenName = "screen_name"
            case type
            case photo100 = "photo_100"
            case photo200 = "photo_200"
            case photo50 = "photo_50"
            
        }
}


