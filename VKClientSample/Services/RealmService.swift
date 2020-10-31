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
    
    func writeToBackgroung(object: Object) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                realm.beginWrite()
                realm.add(object)
                try! realm.commitWrite()
            }
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
    
    func removeCommunity(groupId: Int) {
        guard let realm = try? Realm() else { return }
        let removingCommunity = realm.objects(Community.self).filter("id == %@", groupId)
        
        do {
            realm.beginWrite()
            realm.delete(removingCommunity)
            try realm.commitWrite()
        } catch {
            print("❌❌❌ Realm error\n \(error) ❌❌❌")
        }
    }
    
//    func editCommunityMembership(groupId: Int, isMember: Int) {
//        guard let realm = try? Realm() else { return }
//        let editingObjects = realm.objects(Community.self).filter("id == %@", groupId)
//        
//        if let editingObject = editingObjects.first {
//            try? realm.write {
//                editingObject.isMember =
//                workout.count = plusOne
//            }
//        }
//        print(editingObject)
//        try? realm.write {
//            editingObject
//        }
//    }
    
    
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


extension Realm {
    func writeAsync<T: ThreadConfined>(obj: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }, block: @escaping ((Realm, T?) -> Void)) {
        let wrappedObj = ThreadSafeReference(to: obj)
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let obj = realm.resolve(wrappedObj)
                    
                    try realm.write {
                        block(realm, obj)
                    }
                }
                catch {
                    errorHandler(error)
                }
            }
        }
    }
}

//Use example

//var readEmails = realm.objects(Email.self).filter("read == true")
//
//realm.asyncWrite(readEmails) { (realm, readEmails) in
//    realm.delete(readEmails)
//}
