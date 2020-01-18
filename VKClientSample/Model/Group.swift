//
//  Group.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

struct Group {
    let id: Int
    let title: String
    let description: String
    let groupimg: String
    let followers: Int
    let isFollowing: Bool
}

extension Group {
    static let groups = [
        Group(id: 1, title: "Apple", description: "Mobile technology", groupimg: "apple", followers: 155423, isFollowing: true),
        Group(id: 2, title: "E-Squire", description: "Business", groupimg: "esquire", followers: 801321, isFollowing: true),
        Group(id: 3, title: "Big Geek", description: "Technology, electronics", groupimg: "geek", followers: 31234, isFollowing: false),
        Group(id: 4, title: "Habr", description: "Programming", groupimg: "habr", followers: 1093211, isFollowing: true),
        Group(id: 5, title: "Movies & TV Shows", description: "Movies", groupimg: "movies", followers: 1542, isFollowing: false),
        Group(id: 6, title: "Rozetked", description: "Internet media", groupimg: "rozetked", followers: 258941, isFollowing: true),
        Group(id: 7, title: "The Market", description: "Style, fashion", groupimg: "themarket", followers: 514130, isFollowing: false),
        Group(id: 8, title: "Best wallpapers", description: "Photography", groupimg: "wallpapers", followers: 42351, isFollowing: false)
    ]
}
