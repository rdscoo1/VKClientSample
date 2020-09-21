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
    
//MARK: - Save objects
    
    func saveObject(_ object: Object) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }
    
    func saveObjects(_ objects: [Object]) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }
    
//MARK: - Delete objects
    
    func removeObject(_ object: Object) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.delete(object)
            }
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }
    
    func removeAllObjects<T: Object>(_ type: T.Type) {
        guard let realm = try? Realm() else { return }
        let oldObjects = realm.objects(type)
        do {
            try realm.write {
                realm.delete(oldObjects)
            }
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }
    
    func removeObjectsThanSave<T: Object>(of type: T.Type, objects: [Object]) {
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
    
    func removePhotosThanSave<T: Object>(_ type: T.Type, ownerId: Int, objects: [Object]) {
        guard let realm = try? Realm() else { return }
        let oldObjects = realm.objects(type).filter("ownerId == %@", ownerId)
        do {
            realm.beginWrite()
            realm.delete(oldObjects, cascading: true)
            realm.add(objects, update: .modified)
            try realm.commitWrite()
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }
    
    func removePostsThanSave<T: Object>(_ type: T.Type, object: Object) {
        guard let realm = try? Realm() else { return }
        let oldObject = realm.objects(type)
        
        do {
            realm.beginWrite()
            realm.delete(oldObject, cascading: true)
            realm.add(object, update: .modified)
            try realm.commitWrite()
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }

    
    //MARK: - Get objects
    
    func getAllObjects<T: Object>(of type: T.Type) -> [T] {
        do {
            let realm = try Realm()
            return realm.objects(type).compactMap { $0 }
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
            return []
        }
    }
    
    func getAllObjects<T: Object>(of type: T.Type, with filter: NSPredicate) -> [T] {
        do {
            let realm = try Realm()
            return realm.objects(T.self).filter(filter).compactMap { $0 }
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
            return []
        }
    }
}
