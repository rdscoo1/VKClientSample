//
//  User.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let status: String
    let photo100: String?
    
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
