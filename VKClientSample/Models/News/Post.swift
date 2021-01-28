//
//  Post.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct PostResponse: Decodable {
    let response: Response?
    let error: VKError?
}

struct Response: Decodable {
    var items: [Post]
    var profiles: [PostProfile]
    var groups: [PostCommunity]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
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

struct Post: Decodable {
    var type: String?
    var sourceId: Int?
    var ownerId: Int?
    var postId: Int?
    var date: Double
    var text: String?
    var attachments: [PostAttachment]?
    var comments: Int?
    var likes: Int?
    var reposts: Int?
    var views: Int?
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceId = "source_id"
        case ownerId = "owner_id"
        case postId = "post_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
    
    enum CommentsKeys: CodingKey {
        case count
    }
    
    enum LikesKeys: CodingKey {
        case count
    }
    
    enum RepostsKeys: CodingKey {
        case count
    }
    
    enum ViewsKeys: CodingKey {
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        sourceId = try container.decodeIfPresent(Int.self, forKey: .sourceId)
        ownerId = try container.decodeIfPresent(Int.self, forKey: .ownerId)
        postId = try container.decodeIfPresent(Int.self, forKey: .postId)
        date = try container.decode(Double.self, forKey: .date)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        attachments = try container.decodeIfPresent([PostAttachment].self, forKey: .attachments)
        
        // Flattening objects
        if let commentsContainer = try? container.nestedContainer(keyedBy: CommentsKeys.self, forKey: .comments) {
            comments = try commentsContainer.decode(Int.self, forKey: .count)
        }
        
        if let likesContainer = try? container.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes) {
            likes = try likesContainer.decode(Int.self, forKey: .count)
        }
        
        if let repostsContainer = try? container.nestedContainer(keyedBy: RepostsKeys.self, forKey: .reposts) {
            reposts = try repostsContainer.decode(Int.self, forKey: .count)
            
        }
        
        if let viewsContainer = try? container.nestedContainer(keyedBy: ViewsKeys.self, forKey: .views) {
            views = try viewsContainer.decode(Int.self, forKey: .count)
        }
    }
}

//extension Post: CustomDebugStringConvertible {
//    var debugDescription: String {
//        return "<Post:\(postId)> Text\(String(describing: text)) published \(Date(timeIntervalSince1970: date).getElapsedInterval()) ago.\n This post has photos \(String(describing: photos))\nThis post got \(String(describing: likes?.count)) likes, \(comments.count) comments, \(reposts.count) reposts and \(String(describing: views?.count)) views.\n"
//    }
//}
