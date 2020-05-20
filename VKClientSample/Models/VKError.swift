//
//  VKError.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//


struct VKError: Decodable {
    let errorCode: Int?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_msg"
    }
}
