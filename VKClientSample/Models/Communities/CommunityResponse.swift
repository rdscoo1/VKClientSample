//
//  CommunityResponse.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/17/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

struct CommunityResponse: Decodable {
    let response: Int?
    let error: VKError?
}
