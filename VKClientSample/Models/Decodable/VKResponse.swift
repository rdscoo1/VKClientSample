//
//  VKResponse.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 15.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct VKResponse<T: Decodable>: Decodable {
    let response: Response?
    let error: VKError?
    
    enum CodingKeys: String, CodingKey {
        case response
        case error
    }
    
    struct Response: Decodable {
        let count: Int?
        let items: [T]
        
        enum CodingKeys: String, CodingKey {
            case count
            case items
        }
    }
    
    struct VKError: Decodable {
        let error_code: Int?
        let error_msg: String?
    }
}

struct Section<T> {
    var title: String
    var items: [T]
}

struct Photo<T> {
    var sizes: [T]
}
