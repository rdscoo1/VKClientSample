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
    
    struct Response: Decodable {
        let count: Int?
        let items: [T]
    }
}
