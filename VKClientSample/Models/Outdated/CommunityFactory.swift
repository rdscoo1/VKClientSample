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

extension CommunityFactory {
    static let communities = [
        CommunityFactory(id: 1, title: "Apple", description: "Mobile technology", communityCover: "apple", followers: 155423, isFollowing: true),
        CommunityFactory(id: 2, title: "E-Squire", description: "Business", communityCover: "esquire", followers: 801321, isFollowing: true),
        CommunityFactory(id: 3, title: "Big Geek", description: "Technology, electronics", communityCover: "geek", followers: 31234, isFollowing: false),
        CommunityFactory(id: 4, title: "Habr", description: "Programming", communityCover: "habr", followers: 1093211, isFollowing: true),
        CommunityFactory(id: 5, title: "Movies & TV Shows", description: "Movies", communityCover: "movies", followers: 1542, isFollowing: false),
        CommunityFactory(id: 6, title: "Rozetked", description: "Internet media", communityCover: "rozetked", followers: 258941, isFollowing: true),
        CommunityFactory(id: 7, title: "The Market", description: "Style, fashion", communityCover: "themarket", followers: 514130, isFollowing: false),
        CommunityFactory(id: 8, title: "Best wallpapers", description: "Photography", communityCover: "wallpapers", followers: 42351, isFollowing: false),
        CommunityFactory(id: 9, title: "Droid loves apple", description: "Mobile technology", communityCover: "apple", followers: 5753, isFollowing: true),
        CommunityFactory(id: 10, title: "Make money", description: "Business", communityCover: "esquire", followers: 64564, isFollowing: true),
        CommunityFactory(id: 11, title: "21 century", description: "Technology, electronics", communityCover: "geek", followers: 321132, isFollowing: false),
        CommunityFactory(id: 12, title: "Star", description: "Internet media", communityCover: "rozetked", followers: 2583123941, isFollowing: true),
        CommunityFactory(id: 13, title: "Films", description: "Movies", communityCover: "movies", followers: 3213, isFollowing: false),
        CommunityFactory(id: 14, title: "Shop", description: "Style, fashion", communityCover: "themarket", followers: 514130, isFollowing: false),
        CommunityFactory(id: 15, title: "Photos", description: "Photography", communityCover: "wallpapers", followers: 456, isFollowing: false)
    ]
}

extension CommunityFactory: Hashable { }