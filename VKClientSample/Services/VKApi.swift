//
//  VKApi.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

enum ApiRequests: String {
    case userInfo = "users.get"
    case friends = "friends.get"
    case groups = "groups.get"
    case groupsSearch = "groups.search"
    case photos = "photos.get"
    case newsfeed = "newsfeed.get"
}

class VKApi {
    let apiURL = "https://api.vk.com/method/"
    let defaultParams: Parameters = [
        "access_token": Session.shared.token,
        "v": "5.103"
    ]
    
//    private func makeRequest<ResponseType: Decodable, Object>(apiMethod: ApiRequests,
//                                                      params inputParams: Parameters,
//                                                      httpMethod: HTTPMethod = .get,
//                                                      objectType: Object,
//                                                      completion: @escaping ([ResponseType]) -> Void) {
//        let requestUrl = apiURL + apiMethod.rawValue
//
//        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
//
//        AF.request(requestUrl, method: httpMethod, parameters: params)
//            .validate(statusCode: 200..<300)
//            .responseData { response in
//                switch response.result {
//                case let .success(data):
//                    do {
//                        let decodedModel = try JSONDecoder().decode(VKResponse<ResponseType>.self, from: data)
//                        if let responseData = decodedModel.response {
//                            //                                                        print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
//                            //                                                        print(responseData.items)
//                            completion(responseData.items)
//                        } else if
//                            let errorCode = decodedModel.error?.errorCode,
//                            let errorMsg = decodedModel.error?.errorMessage
//                        {
//                            print("❌ #\(errorCode) \(errorMsg) ❌")
//                        }
//                    } catch {
//                        print("❌ \(error) ❌")
//                    }
//                case let .failure(error):
//                    print("❌ \(error) ❌")
//                }
//        }
//    }
    
    
    func getGroups(completion: @escaping () -> Void) {
        let groupsParams: Parameters = [
            "extended" : "1",
            "fields": "activity"
        ]
        
        let requestUrl = apiURL + ApiRequests.groups.rawValue
        
        let params = defaultParams.merging(groupsParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Community>.self, from: data)
                        if let responseData = decodedModel.response {
                            //                                                        print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
                            //                                                        print(responseData.items)
                            RealmService.manager.removeAllObjects(Community.self)
                            RealmService.manager.saveObjects(responseData.items)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ #\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping () -> Void) {
        let groupsParams: Parameters = [
            "q" : groupName,
            "fields": "activity"
        ]
        
        let requestUrl = apiURL + ApiRequests.groupsSearch.rawValue
        
        let params = defaultParams.merging(groupsParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Community>.self, from: data)
                        if let responseData = decodedModel.response {
                            //                                                        print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
                            //                                                        print(responseData.items)
                            RealmService.manager.removeAllObjects(Community.self)
                            RealmService.manager.saveObjects(responseData.items)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ #\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
    
    func getFriends(completion: @escaping () -> Void) {
        let friendsParams: Parameters = [
            "user_id": Session.shared.userId,
            "order": "hints",
            "fields": "city, photo_50"
        ]
        
        let requestUrl = apiURL + ApiRequests.friends.rawValue
        
        let params = defaultParams.merging(friendsParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Friend>.self, from: data)
                        if let responseData = decodedModel.response {
                            //                                                        print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
                            //                                                        print(responseData.items)
                            RealmService.manager.removeAllObjects(Friend.self)
                            RealmService.manager.saveObjects(responseData.items)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ #\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
    
    func getPhotos(ownerId: Int, completion: @escaping () -> Void) {
        let photosParams: Parameters = [
            "album_id": "profile",
            "owner_id": "\(ownerId)",
            "extended": "1" //для получения лайков
        ]
        
        let requestUrl = apiURL + ApiRequests.friends.rawValue
        
        let params = defaultParams.merging(photosParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Photo>.self, from: data)
                        if let responseData = decodedModel.response {
                            //                                                        print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
                            //                                                        print(responseData.items)
                            RealmService.manager.removeAllObjects(Photo.self)
                            RealmService.manager.saveObjects(responseData.items)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ #\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
    
    func getNewsfeed(completion: @escaping (PostResponse.Response) -> Void) {
        let requestUrl = apiURL + ApiRequests.newsfeed.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "filters": "post",
            "count": "5"
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(PostResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            //                            print(responseData)
                            completion(responseData)
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ #\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
    
    func getUserInfo(userId: String, completion: @escaping () -> Void) {
        let userParams: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "user_ids": userId,
            "fields": "photo_100, status"
        ]
        
        let requestUrl = apiURL + ApiRequests.userInfo.rawValue
        
        AF.request(requestUrl, method: .get, parameters: userParams)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(UserResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            RealmService.manager.removeAllObjects(User.self)
                            RealmService.manager.saveObjects(responseData)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ #\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
}
