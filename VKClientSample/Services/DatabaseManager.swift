//
//  DatabaseManager.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 09.11.2021.
//  Copyright © 2021 Roman Khodukin. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseManagerProtocol: AnyObject {
    /**
     Delete than save array of objects

     - Parameter type: Type of object
     - Parameter objects: Array of objects
     */
    func overwriteObjects(ofType type: Object.Type,
                          objects: [Object]) throws
}

/** Manager to work with database */
class DatabaseManager: DatabaseManagerProtocol {


    func overwriteObjects(ofType type: Object.Type,
                          objects: [Object]) throws {
        guard let realm = try? Realm() else { return }
        let oldObjects = realm.objects(type)

        do {
            realm.beginWrite()
            realm.delete(oldObjects)
            realm.add(objects, update: .modified)
            try realm.commitWrite()
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }


}
