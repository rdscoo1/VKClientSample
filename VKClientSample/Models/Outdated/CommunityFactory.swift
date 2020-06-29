//
//  Community.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

struct CommunityFactory {
    let id: Int
    let title: String
    let description: String
    let communityCover: String
    let followers: Int
    var isFollowing: Bool
}

extension CommunityFactory: Hashable { }
