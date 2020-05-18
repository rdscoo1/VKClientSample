//
//  User.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import RealmSwift

@objcMembers class User: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var status: String = ""
    dynamic var photo100: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case status
        case photo100 = "photo_100"
    }
}

struct UserResponse<T: Decodable>: Decodable {
    let response: [T]?
    let error: VKError?
    
    struct VKError: Decodable {
        let errorCode: Int?
        let errorMessage: String?
        
        enum CodingKeys: String, CodingKey {
            case errorCode = "error_code"
            case errorMessage = "error_msg"
        }
    }
}
