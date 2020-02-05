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

struct Friend {
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

extension Friend {
    static let friends = [
        Friend(id: 1, name: "Roman", surname: "Khodukin", avatar: "john", age: 21, location: "Moscow", sex: .male, isOnline: false, photos: ["john", "helen", "alina", "anya", "galgadot", "irina", "maria", "andrey"]),
        Friend(id: 2, name: "Helen", surname: "Moss", avatar: "helen", age: 24, location: "NY", sex: .female, isOnline: true, photos: ["helen", "alina", "anya", "galgadot", "irina", "maria", "andrey", "john"]),
        Friend(id: 3, name: "Alina", surname: "Minskaya", avatar: "alina", age: 30, location: "Saint-Petersburg", sex: .female, isOnline: false, photos: ["alina", "helen", "anya", "galgadot", "irina", "maria", "andrey", "john"]),
        Friend(id: 4, name: "Anna", surname: "Kirina", avatar: "anya", age: 18, location: "Kursk", sex: .female, isOnline: true, photos: ["anya", "helen", "alina", "galgadot", "irina", "maria", "andrey", "john"]),
        Friend(id: 5, name: "Gal", surname: "Gadot", avatar: "galgadot", age: 34, location: "Israel", sex: .female, isOnline: true, photos: ["galgadot", "helen", "alina", "anya", "irina", "maria", "andrey", "john"]),
        Friend(id: 6, name: "Irina", surname: "Prikolotina", avatar: "irina", age: 20, location: "Miami", sex: .female, isOnline: false, photos: ["irina", "helen", "alina", "anya", "galgadot", "maria", "andrey", "john"]),
        Friend(id: 7, name: "Maria", surname: "Ishunina", avatar: "maria", age: 45, location: "Sochi", sex: .female, isOnline: false, photos: ["maria", "helen", "alina", "anya", "galgadot", "irina", "andrey", "john"]),
        Friend(id: 8, name: "Andrey", surname: "Arifulin", avatar: "andrey", age: 27, location: "Moscow", sex: .male, isOnline: true, photos: ["andrey", "helen", "alina", "anya", "galgadot", "irina", "maria", "john"]),
        Friend(id: 9, name: "Dmitry", surname: "Nagiev", avatar: "john", age: 21, location: "Moscow", sex: .male, isOnline: false, photos: ["john", "helen", "alina", "anya", "galgadot", "irina", "maria", "andrey"]),
        Friend(id: 10, name: "Kate", surname: "Spoor", avatar: "helen", age: 24, location: "NY", sex: .female, isOnline: true, photos: ["helen", "alina", "anya", "galgadot", "irina", "maria", "andrey", "john"]),
        Friend(id: 11, name: "Masha", surname: "Kirina", avatar: "alina", age: 30, location: "Saint-Petersburg", sex: .female, isOnline: false, photos: ["alina", "helen", "anya", "galgadot", "irina", "maria", "andrey", "john"]),
        Friend(id: 12, name: "Mila", surname: "June", avatar: "anya", age: 18, location: "Kursk", sex: .female, isOnline: true, photos: ["anya", "helen", "alina", "galgadot", "irina", "maria", "andrey", "john"]),
        Friend(id: 13, name: "Diana", surname: "Princess", avatar: "galgadot", age: 34, location: "Israel", sex: .female, isOnline: true, photos: ["galgadot", "helen", "alina", "anya", "irina", "maria", "andrey", "john"]),
        Friend(id: 14, name: "Jina", surname: "Lotty", avatar: "irina", age: 20, location: "Miami", sex: .female, isOnline: false, photos: ["irina", "helen", "alina", "anya", "galgadot", "maria", "andrey", "john"]),
        Friend(id: 15, name: "Linda", surname: "Snakes", avatar: "maria", age: 45, location: "Sochi", sex: .female, isOnline: false, photos: ["maria", "helen", "alina", "anya", "galgadot", "irina", "andrey", "john"]),
        Friend(id: 16, name: "Michael", surname: "Mountin", avatar: "andrey", age: 27, location: "Moscow", sex: .male, isOnline: true, photos: ["andrey", "helen", "alina", "anya", "galgadot", "irina", "maria", "john"])
    ]
}

extension Friend {
    var titleFirstLetter: String {
        return String(self.surname[self.surname.startIndex]).uppercased()
    }
}
