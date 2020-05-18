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
        let errorCode: Int?
        let errorMessage: String?
        
        enum CodingKeys: String, CodingKey {
            case errorCode = "error_code"
            case errorMessage = "error_msg"
        }
    }
}

struct PhotoResponse<T> {
    var sizes: [T]
}
