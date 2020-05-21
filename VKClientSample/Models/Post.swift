//
//  Post.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

struct PostResponse: Decodable {
    let response: Response?
    let error: VKError?
    
    struct Response: Decodable {
        let items: [Post]
        let groups: [Community]
    }
}

struct Post: Decodable {
    let postId: Int
    let date: Double
    let text: String?
    let attachments: [Attachment?]
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
    
    struct Attachment: Decodable {
        let type: String
        let photo: Photo?
    }
    
    struct Comments: Decodable {
        let count: Int
    }
    
    struct Likes: Decodable {
        let count: Int
        let canLike: Int?
        
        enum CodingKeys: String, CodingKey {
            case count
            case canLike = "can_like"
        }
    }
    
    struct Reposts: Decodable {
        let count: Int
    }
    
    struct Views: Decodable {
        let count: Int
    }
}
