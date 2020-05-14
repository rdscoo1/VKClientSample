//
//  File.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

struct VKPost: Decodable {
    let date: Int
    let text: String
    let attachments: Attachment?
    
    enum CodingKeys: String, CodingKey {
        case date
        case text
        case attachments
    }
    
    struct Attachment: Decodable {
        let type: String
        let link: Link?
        
        enum CodingKeys: String, CodingKey {
            case type
            case link
        }
        
        struct Link: Decodable {
            let title: String
            let description: String
            let photo: VKPhoto?
        }
    }
}
