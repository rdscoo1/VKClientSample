//
//  Friend.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift



@objcMembers class Friend: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var online: Int = 0
    dynamic var city: String? = nil
    dynamic var imageUrl: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case city
        case imageUrl = "photo_50"
        
        enum CityKeys: CodingKey {
            case title
        }
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .firstName)
        online = try container.decode(Int.self, forKey: .online)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        
        if let cityContainer = try? container.nestedContainer(keyedBy: CodingKeys.CityKeys.self, forKey: .city) {
            city = try cityContainer.decodeIfPresent(String.self, forKey: .title)
        }
    }
    
    override static func primaryKey() -> String? { // По `id`  при совпадении: перезаписывает, а не дублирует
        return "id"
    }
    
    
}

struct FriendSection {
    var firstLetter: String
    var items: [Friend]
}

//extension Friend {
//   override var debugDescription: String {
//      return "<Friend:\(id)> \(firstName) \(lastName) who is from \(String(describing: city)). His photo url is \(String(describing: imageUrl))"
//   }
//}


