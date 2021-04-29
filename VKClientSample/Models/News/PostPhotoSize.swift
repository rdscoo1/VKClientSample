//
//  PostPhotoSize.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct PostPhotoSize: Decodable {
    let height: Int
    let width: Int
    let type: String
    let url: String
}
