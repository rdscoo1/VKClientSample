//
//  Post.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

class PostResponse: Decodable {
    var response: Response?
    let error: VKError?
}

class Response: Object, Decodable {
    @objc dynamic var id: String = UUID().uuidString
    var items = List<Post>()
    var profiles = List<PostProfile>()
    var groups = List<PostCommunity>()
    @objc dynamic var nextFrom: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
    
    //        func addTo(news: Response) {
    ////            if news.items
    //            self.items = news.items
    //        }
    
    //        func addToBeggining(news: Response) {
    //            self.items = news.items + self.items
    //            self.profiles = news.profiles + self.profiles
    //            self.groups = news.groups + self.groups
    //        }
    //
    //        func addToEnd(news: Response) {
    //            self.items = self.items + news.items
    //            self.profiles = self.profiles + news.profiles
    //            self.groups = self.groups + news.groups
    //        }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

@objcMembers
class Post: Object, Decodable {
    dynamic var type: String = ""
    dynamic var sourceId: Int = 0
    dynamic var postId: Int = 0
    dynamic var date: Double = 0.0
    dynamic var text: String? = nil
    var attachments = List<PostAttachment>()
    //    @objc dynamic var attachmentType: String = ""
    //    var photo = List<PostPhoto>()
    //    var photos: [Photo]?
    dynamic var comments: Int = 0
    dynamic var likes: Int = 0
    dynamic var reposts: Int = 0
    dynamic var views: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceId = "source_id"
        case postId = "post_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
    
    //    enum AttachmentsKeys: String, CodingKey {
    //        case attachmentType = "type"
    //        case photo
    //    }
    
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
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        sourceId = try container.decode(Int.self, forKey: .sourceId)
        postId = try container.decode(Int.self, forKey: .postId)
        date = try container.decode(Double.self, forKey: .date)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        
        
        if let attachment = try? container.decode(List<PostAttachment>.self, forKey: .attachments) {
            self.attachments = attachment
        }
        
        //        if let attachmentsContainer = try? container.nestedContainer(keyedBy: AttachmentsKeys.self, forKey: .attachments) {
        //            attachmentType = try attachmentsContainer.decode(String.self, forKey: .attachmentType)
        //            photo = try attachmentsContainer.decode(List<PostPhoto>.self, forKey: .photo)
        //        }
        //        photos = try container.decodeIfPresent(Array<Photo>.self, forKey: .photos)
        
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
    
    override class func primaryKey() -> String? {
        return "postId"
    }
}

//extension Post: CustomDebugStringConvertible {
//    var debugDescription: String {
//        return "<Post:\(postId)> Text\(String(describing: text)) published \(Date(timeIntervalSince1970: date).getElapsedInterval()) ago.\n This post has photos \(String(describing: photos))\nThis post got \(String(describing: likes?.count)) likes, \(comments.count) comments, \(reposts.count) reposts and \(String(describing: views?.count)) views.\n"
//    }
//}
