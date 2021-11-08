//
//  CommunityCover.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import RealmSwift

class CommunityCover: Object, Decodable {
    @objc dynamic var enabled: Int = 0
    var images = List<CommunityCoverImages>()
    
    var imageUrl: String {
        guard let photoLink = images.first(where: { $0.width == 795 })?.url else {
            return ""
        }
        return photoLink
    }
    
    enum CodingKeys: String, CodingKey {
        case enabled
        case images
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        enabled = try container.decode(Int.self, forKey: .enabled)
        if let images = try? container.decode(List<CommunityCoverImages>.self, forKey: .images) {
            self.images = images
        }
    }
}
