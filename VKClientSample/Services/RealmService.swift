//
//  RealmService.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let manager = RealmService()
    
    private init() {}

//MARK: - Save & Remove
    func saveObject(_ object: Object) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("❌ \(error) ❌")
        }
    }
    
    func saveObjects(_ objects: [Object]) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print("❌ \(error) ❌")
        }
    }
    
    func removeObject(_ object: Object) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.delete(object)
            }
        } catch {
            print("❌ \(error) ❌")
        }
    }
    
    func removeAllObjects<T: Object>(_ object: T.Type) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.delete(getAllObjects(of: object))
            }
        } catch {
            print("❌ \(error) ❌")
        }
    }
    
    //MARK: - Get
    func getAllObjects<T: Object>(of type: T.Type) -> [T] {
        do {
            let realm = try Realm()
            return realm.objects(type).compactMap { $0 }
        } catch {
            print("❌ \(error) ❌")
            return []
        }
    }
    
    func getAllObjects<T: Object>(_ type: T.Type, with filter: NSPredicate) -> [T] {
        do {
            let realm = try Realm()
            return realm.objects(T.self).filter(filter).compactMap { $0 }
        } catch {
            print("❌ \(error) ❌")
            return []
        }
    }
}
