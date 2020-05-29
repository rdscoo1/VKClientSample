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
        let profiles: [User]
        let groups: [Community]
    }
}

struct Post: Decodable {
    let type: String
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String?
    let attachments: [Attachment]
    let photos: [Photo]?
    let comments: Comments
    let likes: Likes?
    let reposts: Reposts
    let views: Views?
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceId = "source_id"
        case postId = "post_id"
        case date
        case text
        case attachments
        case photos
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

extension Post: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<Post:\(postId)>\nText\(String(describing: text)) published \(Date(timeIntervalSince1970: date).getElapsedInterval()) ago. It has photo with url .\n This post got \(String(describing: likes?.count)) likes, \(comments.count) comments, \(reposts.count) reposts and \(String(describing: views?.count)) views."
    }
}
