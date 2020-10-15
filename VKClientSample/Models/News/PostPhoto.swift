//
//  PostPhoto.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 9/21/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

struct PostPhoto: Decodable {
    let id: Int
    let sizes: [PostPhotoSize]?
    var highResPhoto: String {
        guard let photoLinkhighRes = sizes?.first(where: { $0.type == "x" })?.url else {
            return ""
        }
        return photoLinkhighRes
    }
}
