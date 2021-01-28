//
//  PostLink.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct PostLink: Decodable {
    let url: String
    let title: String
    let description: String?
    let caption: String?
    let photo: Photo?
}
