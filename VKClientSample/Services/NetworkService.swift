//
//  NetworkService.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

//MARK: - Api Methods

class NetworkService {
    
    //MARK: - Constants
    
    private let apiURL = "https://\(Constants.baseUrl)/method/"
    private let defaultParams: Parameters = [
        "access_token": Session.shared.token,
        "v": "5.103"
    ]
    
    //MARK: - Private Methods
    
    private func makeRequest<ResponseType>(
            apiPath: Constants.ApiPath,
            params inputParams: Parameters,
            httpMethod: HTTPMethod = .get,
            objectType: ResponseType.Type,
            completion: @escaping () -> Void) where ResponseType: Object, ResponseType: Decodable {
            let requestUrl = apiURL + apiPath.rawValue
            
            let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
            
            AF.request(requestUrl, method: httpMethod, parameters: params)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case let .success(data):
                        do {
                            let decodedModel = try JSONDecoder().decode(VKResponse<ResponseType>.self, from: data)
                            if let responseData = decodedModel.response {
                                //                            print("📩📩📩 Method \(apiMethod.rawValue) response: 📩📩📩")
                                //                            print(responseData.items)
                                
                                RealmService.manager.removeObjectsThanSave(of: ResponseType.self, objects: responseData.items)
                                completion()
                            } else if
                                let errorCode = decodedModel.error?.errorCode,
                                let errorMsg = decodedModel.error?.errorMessage
                            {
                                print("❌ VKApi \(apiPath.rawValue) error\n\(errorCode) \(errorMsg) ❌")
                            }
                        } catch {
                            print("❌ Decoding \(VKResponse<ResponseType>.self) failed ❌\n\(error)")
                        }
                    case let .failure(error):
                        print("❌ Alamofire error\n \(error) ❌")
                    }
                }
        }
        
        //MARK: - Public Methods
        
        func getFriends(completion: @escaping () -> Void) {
            let params: Parameters = [
                "user_id": Session.shared.userId,
                "order": "hints",
                "fields": "city,photo_50,online"
            ]
            
            makeRequest(apiPath: .friends, params: params, objectType: Friend.self, completion: completion)
        }

    
    // MARK: - Groups methods
    
    func joinGroup(groupId: Int, completion: @escaping (CommunityResponse) -> Void) {
        let inputParams: Parameters = [ "group_id": groupId ]
        
        let requestUrl = apiURL + Constants.ApiPath.groupJoin.rawValue
        
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .post, parameters: params)
            .validate()
            .responseData() { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedModel = try JSONDecoder().decode(CommunityResponse.self, from: data)
                        if decodedModel.response != nil {
                                completion(decodedModel)
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ NetworkService \(Constants.ApiPath.groupJoin.rawValue) error\n\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ Decoding \(CommunityResponse.self) failed ❌\n\(error)")
                    }
                case .failure(let error):
                    print("❌ Alamofire error\n \(error) ❌")
                }
            }
    }
    
    func leaveGroup(groupId: Int, completion: @escaping (CommunityResponse) -> Void) {
        let inputParams: Parameters = [ "group_id": groupId ]
        
        let requestUrl = apiURL + Constants.ApiPath.groupLeave.rawValue
        
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .post, parameters: params)
            .validate()
            .responseData() { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedModel = try JSONDecoder().decode(CommunityResponse.self, from: data)
                        if decodedModel.response != nil {
                                completion(decodedModel)
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ NetworkService \(Constants.ApiPath.groupLeave.rawValue) error\n\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ Decoding \(CommunityResponse.self) failed ❌\n\(error)")
                    }
                case .failure(let error):
                    print("❌ Alamofire error\n \(error) ❌")
                }
            }
    }
    
    func getGroups(completion: @escaping () -> Void) {
        let inputParams: Parameters = [
            "extended" : "1",
            "fields": "activity,status,members_count,cover"
        ]
        
        let requestUrl = apiURL + Constants.ApiPath.groups.rawValue
        
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData(queue: .global(qos: .utility)) { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Community>.self, from: data)
                        if let responseData = decodedModel.response {
                            DispatchQueue.main.async {
                                RealmService.manager.removeObjectsThanSave(of: Community.self, objects: responseData.items)
                                completion()
                            }
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ NetworkService \(Constants.ApiPath.groups.rawValue) error\n\(errorCode) \(errorMsg) ❌")
                        }
                    } catch {
                        print("❌ Decoding \(VKResponse<Community>.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error\n \(error) ❌")
                }
            }
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping ([Community]) -> Void) {
        let searchParams: Parameters = [
            "q" : groupName,
            "fields": "activity,status,members_count,cover"
        ]
        
        let requestUrl = apiURL + Constants.ApiPath.groupsSearch.rawValue
        
        let params = defaultParams.merging(searchParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData(queue: .global(qos: .utility)) { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<Community>.self, from: data)
                        if let responseData = decodedModel.response {
                            DispatchQueue.main.async {
                                completion(responseData.items)
                            }
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ NetworkService \(Constants.ApiPath.groupsSearch.rawValue) error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding \(VKResponse<Community>.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
            }
    }
    
    func getPhotos(ownerId: Int, completion: @escaping () -> Void) {
        let requestUrl = apiURL + Constants.ApiPath.photos.rawValue
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "album_id": "profile",
            "owner_id": "\(ownerId)"
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
                            print("❌ NetworkService \(Constants.ApiPath.photos.rawValue) error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding \(VKResponse<Photo>.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
            }
    }
    
    func getNewsfeed(nextBatch: String?, startTime: String?, completion: @escaping (Response) -> Void) {
        let requestUrl = apiURL + Constants.ApiPath.newsfeed.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.124",
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
                            print("❌ NetworkService \(Constants.ApiPath.newsfeed.rawValue) error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding \(PostResponse.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
            }
    }
    
    func getStories(completion: @escaping (StoryResponse) -> Void) {
        let requestUrl = apiURL + Constants.ApiPath.stories.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.120",
            "extended": 1
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData(queue: .global(qos: .utility)) { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(StoriesResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            //                            print("📩📩📩 Methood \(ApiRequests.stories.rawValue) response: 📩📩📩")
                            DispatchQueue.main.async {
                                completion(responseData)
                            }
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ NetworkService \(Constants.ApiPath.stories.rawValue) error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding \(StoriesResponse.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
            }
    }
    
    func getUserInfo(userId: String, completion: @escaping ([User]) -> Void) {
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "user_ids": userId,
            "fields": "photo_100, status"
        ]
        
        let requestUrl = apiURL + Constants.ApiPath.userInfo.rawValue
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(UserResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            //                            RealmService.manager.removeObjectsThanSave(of: User.self, objects: responseData)
                            completion(responseData)
                        } else if
                            let errorCode = decodedModel.error?.errorCode,
                            let errorMsg = decodedModel.error?.errorMessage
                        {
                            print("❌ NetworkService \(Constants.ApiPath.userInfo.rawValue) error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding \(UserResponse.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
            }
    }
    
    func getWall(ownerId: Int, completion: @escaping (Response) -> Void) {
        let requestUrl = apiURL + Constants.ApiPath.wall.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.124",
            "extended": 1,
            "owner_id": -ownerId
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
                            print("❌ NetworkService \(Constants.ApiPath.wall.rawValue) error ❌\n\(errorCode) \(errorMsg)")
                        }
                    } catch {
                        print("❌ Decoding \(PostResponse.self) failed ❌\n\(error)")
                    }
                case let .failure(error):
                    print("❌ Alamofire error ❌\n \(error)")
                }
            }
    }
}
