//
//  Session.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 24.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session() //создаём singleton
    
    var token: String = "" // Хранение токена VK
    var userId: String = "" // Хранение id пользователя вк
    
    private init() {}
}
