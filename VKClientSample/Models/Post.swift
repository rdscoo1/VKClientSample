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
        var items: [Post]
        var profiles: [User]
        var groups: [Community]
        let nextFrom: String?
        
        enum CodingKeys: String, CodingKey {
            case items
            case profiles
            case groups
            case nextFrom = "next_from"
        }
        
        mutating func addTo(news: Response) {
//            if news.items
            self.items = news.items
        }
        
        mutating func addToBeggining(news: Response) {
            self.items = news.items + self.items
            self.profiles = news.profiles + self.profiles
            self.groups = news.groups + self.groups
        }
        
        mutating func addToEnd(news: Response) {
            self.items = self.items + news.items
            self.profiles = self.profiles + news.profiles
            self.groups = self.groups + news.groups
        }
    }
}

struct Post: Decodable {
    let type: String
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String?
    let attachments: [Attachment]?
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
        let link: Link?
        
        struct Link: Decodable {
            let url: String
            let title: String
            let description: String?
            let caption: String?
            let photo: Photo?
        }
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

//extension Post: CustomDebugStringConvertible {
//    var debugDescription: String {
//        return "<Post:\(postId)> Text\(String(describing: text)) published \(Date(timeIntervalSince1970: date).getElapsedInterval()) ago.\n This post has photos \(String(describing: photos))\nThis post got \(String(describing: likes?.count)) likes, \(comments.count) comments, \(reposts.count) reposts and \(String(describing: views?.count)) views.\n"
//    }
//}
