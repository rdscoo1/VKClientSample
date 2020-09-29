//
//  Friend.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

enum Sex {
    case male, female, none
}

struct FriendFactory {
    let id: Int
    let name: String
    let surname: String
    let avatar: String
    let age: Int
    let location: String
    let sex: Sex
    let isOnline: Bool
    let photos: [String]
}

extension FriendFactory {
    static let friends = [
        FriendFactory(id: 1, name: "Roman", surname: "Khodukin", avatar: "anya", age: 21, location: "Moscow", sex: .male, isOnline: false, photos: ["anya", "anya"]),
        FriendFactory(id: 2, name: "Helen", surname: "Moss", avatar: "anya", age: 24, location: "NY", sex: .female, isOnline: true, photos: ["anya"]),
        FriendFactory(id: 3, name: "Alina", surname: "Minskaya", avatar: "anya", age: 30, location: "Saint-Petersburg", sex: .female, isOnline: false, photos: ["anya", "anya"]),
        FriendFactory(id: 4, name: "Anna", surname: "Kirina", avatar: "anya", age: 18, location: "Kursk", sex: .female, isOnline: true, photos: ["anya", "anya"]),
        FriendFactory(id: 5, name: "Gal", surname: "Gadot", avatar: "anya", age: 34, location: "Israel", sex: .female, isOnline: true, photos: ["anya", "anya"]),
        FriendFactory(id: 6, name: "Irina", surname: "Prikolotina", avatar: "anya", age: 20, location: "Miami", sex: .female, isOnline: false, photos: ["anya", "anya"]),
        FriendFactory(id: 7, name: "Maria", surname: "Ishunina", avatar: "anya", age: 45, location: "Sochi", sex: .female, isOnline: false, photos: ["anya", "anya", "anya"]),
        FriendFactory(id: 8, name: "Andrey", surname: "Arifulin", avatar: "anya", age: 27, location: "Moscow", sex: .male, isOnline: true, photos: ["anya", "anya", "anya"]),
        FriendFactory(id: 9, name: "Dmitry", surname: "Nagiev", avatar: "anya", age: 21, location: "Moscow", sex: .male, isOnline: false, photos: ["anya", "anya"]),
        FriendFactory(id: 10, name: "Kate", surname: "Spoor", avatar: "anya", age: 24, location: "NY", sex: .female, isOnline: true, photos: ["anya"]),
        FriendFactory(id: 11, name: "Masha", surname: "Kirina", avatar: "anya", age: 30, location: "Saint-Petersburg", sex: .female, isOnline: false, photos: ["anya", "anya"]),
        FriendFactory(id: 12, name: "Mila", surname: "June", avatar: "anya", age: 18, location: "Kursk", sex: .female, isOnline: true, photos: ["anya", "anya"]),
        FriendFactory(id: 13, name: "Diana", surname: "Princess", avatar: "anya", age: 34, location: "Israel", sex: .female, isOnline: true, photos: ["anya", "anya", "anya"]),
        FriendFactory(id: 14, name: "Jina", surname: "Lotty", avatar: "anya", age: 20, location: "Miami", sex: .female, isOnline: false, photos: ["anya", "anya"]),
        FriendFactory(id: 15, name: "Linda", surname: "Snakes", avatar: "anya", age: 45, location: "Sochi", sex: .female, isOnline: false, photos: ["anya", "anya", "anya", "anya"]),
        FriendFactory(id: 16, name: "Michael", surname: "Mountin", avatar: "anya", age: 27, location: "Moscow", sex: .male, isOnline: true, photos: ["anya"])
    ]
}

extension FriendFactory {
    var titleFirstLetter: String {
        return surname[surname.startIndex].uppercased()
    }
}
