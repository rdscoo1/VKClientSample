//
//  RealmService.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    var realm: Realm { get }
    
    func saveObject(_ object: Object)
    func saveObjects(_ objects: [Object])
    func removeObject(_ object: Object)
}

class RealmService: RealmServiceProtocol {
    static let manager = RealmService()
    let realm = try! Realm()
    
    private init() {}
    
    func saveObject(_ object: Object) {
//        print("URL: \(realm.configuration.fileURL!)")
        try? realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func saveObjects(_ objects: [Object]) {
//        print("URL: \(realm.configuration.fileURL!)")
        try? realm.write {
            realm.add(objects, update: .modified)
        }
    }
    
    func removeObject(_ object: Object) {
        try? realm.write {
            realm.delete(object)
        }
    }
    
    func getAll<T: Object>(_ type: T.Type) -> [T] {
        return realm.objects(type).compactMap { $0 }
    }
}
