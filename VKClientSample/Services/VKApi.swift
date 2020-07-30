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
    
    private func makeRequest<ResponseType>(
        apiMethod: ApiRequests,
        params inputParams: Parameters,
        httpMethod: HTTPMethod = .get,
        objectType: ResponseType.Type,
        completion: @escaping () -> Void) where ResponseType: Object, ResponseType: Decodable {
        let requestUrl = apiURL + apiMethod.rawValue
        
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: httpMethod, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<ResponseType>.self, from: data)
                        if let responseData = decodedModel.response {
                            //                                                        print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
                            //                                                        print(responseData.items)
                            RealmService.manager.removeObjectsThanSave(of: ResponseType.self, objects: responseData.items)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ VKApi error\n\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ Decoding failed\n\(error) ❌")
                    }
                case let .failure(error):
                    print("❌ Alamofire error\n \(error) ❌")
                }
        }
    }
    
    
    func getGroups() {
        let inputParams: Parameters = [
            "extended" : "1",
            "fields": "activity"
        ]
        
        let requestUrl = apiURL + ApiRequests.groups.rawValue
        
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Community>.self, from: data)
                        if let responseData = decodedModel.response {
                            RealmService.manager.removeObjectsThanSave(of: Community.self, objects: responseData.items)
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ VKApi error\n\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ Decoding failed\n\(error) ❌")
                    }
                case let .failure(error):
                    print("❌ Alamofire error\n \(error) ❌")
                }
        }
    }
    
    func getFriends(completion: @escaping () -> Void) {
        let params: Parameters = [
            "user_id": Session.shared.userId,
            "order": "hints",
            "fields": "city, photo_50"
        ]
        
        makeRequest(apiMethod: .friends, params: params, objectType: Friend.self, completion: completion)
    }
    
    func getSearchedGroups(groupName: String) {
        let searchParams: Parameters = [
            "q" : groupName,
            "fields": "activity"
        ]
        
        let requestUrl = apiURL + ApiRequests.groupsSearch.rawValue
        
        let params = defaultParams.merging(searchParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Community>.self, from: data)
                        if let responseData = decodedModel.response {
                            RealmService.manager.removeObjectsThanSave(of: Community.self, objects: responseData.items)
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ VKApi error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding failed ❌\n\(error) ")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
        }
    }
    
    func getPhotos(ownerId: Int, completion: @escaping () -> Void) {
        let requestUrl = apiURL + ApiRequests.photos.rawValue
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "album_id": "profile",
            "owner_id": "\(ownerId)",
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Photo>.self, from: data)
                        if let responseData = decodedModel.response {
                            RealmService.manager.removePhotosThanSave(Photo.self, ownerId: ownerId, objects: responseData.items)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ VKApi error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding failed ❌\n\(error) ")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
        }
    }
    
    func getNewsfeed(nextBatch: String?, startTime: String?, completion: @escaping (PostResponse.Response) -> Void) {
        let requestUrl = apiURL + ApiRequests.newsfeed.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.120",
            "filters": "post",
            "count": "20",
            "start_from": "\(nextBatch ?? "")",
            "start_time": "\(startTime ?? "")"
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData(queue: .global(qos: .utility)) { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(PostResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            //                            print("📩📩📩 Methood \(ApiRequests.newsfeed.rawValue) response: 📩📩📩")
                            //                            print(responseData)
                            DispatchQueue.main.async {
                                completion(responseData)
                                
                            }
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ VKApi error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding failed ❌\n\(error) ")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
        }
    }
    
    func getUserInfo(userId: String, completion: @escaping () -> Void) {
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "user_ids": userId,
            "fields": "photo_100, status"
        ]
        
        let requestUrl = apiURL + ApiRequests.userInfo.rawValue
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(UserResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            RealmService.manager.removeObjectsThanSave(of: User.self, objects: responseData)
                            completion()
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ VKApi error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding failed ❌\n\(error) ")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
        }
    }
}
