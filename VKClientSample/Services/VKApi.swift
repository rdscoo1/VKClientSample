//
//  VKApi.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation
import Alamofire

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
    
    private func makeRequest<ResponseType: Decodable>(apiMethod: ApiRequests,
                                                      params inputParams: Parameters,
                                                      httpMethod: HTTPMethod = .get,
                                                      completion: @escaping ([ResponseType]) -> Void) {
        let requestUrl = apiURL + apiMethod.rawValue
        let defaultParams: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103"
        ]
        
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
                            completion(responseData.items)
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
    
    
    func getGroups(completion: @escaping ([Community]) -> Void) {
        let params: Parameters = [
            "extended" : "1",
            "fields": "activity"
        ]
        
        makeRequest(apiMethod: .groups, params: params, completion: completion)
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping ([Community]) -> Void) {
        let params: Parameters = [
            "q" : groupName,
            "fields": "activity"
        ]
        
        makeRequest(apiMethod: .groupsSearch, params: params, completion: completion)
    }
    
    func getFriends(completion: @escaping ([Friend]) -> Void) {
        let params: Parameters = [
            "user_id": Session.shared.userId,
            "order": "hints",
            "fields": "city, photo_50"
        ]
        
        makeRequest(apiMethod: .friends, params: params, completion: completion)
    }
    
    func getPhotos(ownerId: Int, completion: @escaping ([Photo]) -> Void) {
        let params: Parameters = [
            "album_id": "profile",
            "owner_id": "\(ownerId)",
            "extended": "1" //для получения лайков
        ]
        
        makeRequest(apiMethod: .photos, params: params, completion: completion)
    }
    
    func getNewsfeed(completion: @escaping (PostResponse.Response) -> Void) {
        let requestUrl = apiURL + ApiRequests.newsfeed.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "filters": "post,photo,wall_photo",
            "count": "1"
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(PostResponse.self, from: data)
                        if let responseData = decodedModel.response {
                            print(responseData)
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
    
    func getUserInfo(userId: String, completion: @escaping ([User]) -> Void) {
        let requestUrl = apiURL + ApiRequests.userInfo.rawValue
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.103",
            "user_ids": userId,
            "fields": "photo_100, status"
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(UserResponse.self, from: data)
                        if let responseData = decodedModel.response {
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
}
