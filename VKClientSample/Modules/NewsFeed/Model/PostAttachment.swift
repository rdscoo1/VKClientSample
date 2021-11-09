//
//  PostAttachment.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/22/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

class PostAttachment: Decodable {
    let type: String
    let photo: PostPhoto?
}
