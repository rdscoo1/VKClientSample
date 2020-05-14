//
//  VKUser.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

protocol VKUserProtocol {
    var firstName: String { get }
    var lastName: String { get }
    var status: String { get }
    var photo100: String? { get }
}

struct VKUser: Decodable, VKUserProtocol {
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

struct VKUserResponse<T: Decodable>: Decodable {
    let response: [T]?
    let error: VKError?
    
    struct VKError: Decodable {
        let error_code: Int?
        let error_msg: String?
    }
}
