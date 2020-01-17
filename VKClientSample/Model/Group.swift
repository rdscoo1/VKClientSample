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
    let isFollowing: Bool
}

extension Group {
    static let groups = [
        Group(id: 1, title: "Apple", description: "Mobile technology", groupimg: "apple", isFollowing: true),
        Group(id: 2, title: "E-Squire", description: "Business", groupimg: "esquire", isFollowing: true),
        Group(id: 3, title: "Big Geek", description: "Technology, electronics", groupimg: "geek", isFollowing: false),
        Group(id: 4, title: "Habr", description: "Programming", groupimg: "habr", isFollowing: true),
        Group(id: 5, title: "Movies & TV Shows", description: "Movies", groupimg: "movies", isFollowing: false),
        Group(id: 6, title: "Rozetked", description: "Internet media", groupimg: "rozetked", isFollowing: true),
        Group(id: 7, title: "The Market", description: "Style, fashion", groupimg: "themarket", isFollowing: false),
        Group(id: 8, title: "Best wallpapers", description: "Photography", groupimg: "wallpapers", isFollowing: false)
    ]
}
