//
//  VKProfile.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

protocol VKProfileProtocol {
    var firstName: String { get }
    var lastName: String { get }
    var status: String { get }
}

struct VKUser: Decodable, VKProfileProtocol {
    let id: Int
    let firstName: String
    let lastName: String
    let homeTown: String
    let status: String
    let birthDate: String
    let city: City?
    let country: Country?
    let phone: String
    let screenName: String
    let sex: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case homeTown = "home_town"
        case status
        case birthDate = "bdate"
        case city
        case country
        case phone
        case screenName = "screen_name"
        case sex
    }
}

extension VKUser {
    struct City: Decodable {
        let title: String?
    }
    
    struct Country: Decodable {
        let title: String?
    }
}
