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
    case allPhotos = "photos.getAll"
}

class VKApi {
    let apiURL = "https://api.vk.com/method/"
    let token = Session.shared.token
    let userId = Session.shared.userId
    
    private func makeRequest<ResponseType: Decodable>(request: ApiRequests,
                                                      params inputParams: Parameters,
                                                      method: HTTPMethod = .get,
                                                      completion: @escaping ([ResponseType]) -> Void) {
        let requestUrl = apiURL + request.rawValue
        let defaultParams: Parameters = [
            "access_token": token,
            "v": "5.103"
        ]
        
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: method, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKResponse<ResponseType>.self, from: data)
                        guard let responseData = decodedModel.response else {
                            return
                        }
//                        print("📩📩📩 Method \(request.rawValue) response: 📩📩📩")
//                        print(responseData.items)
                        completion(responseData.items)
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
    
    func getGroups(completion: @escaping ([VKCommunity]) -> Void) {
        let params: Parameters = [
            "extended" : "1",
            "fields": "activity,"
                + "description"
        ]
        
        makeRequest(request: .groups, params: params, completion: completion)
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping ([VKCommunity]) -> Void) {
        let params: Parameters = [
            "q" : groupName,
            "fields": "activity,"
                + "description"
        ]
        
        makeRequest(request: .groupsSearch, params: params, completion: completion)
    }
    
    func getFriends(completion: @escaping ([VKFriend]) -> Void) {
        let params: Parameters = [
            "user_id": userId,
            "order": "hints",
            "fields": "city,"
                + "photo_200_orig"
        ]
        
        makeRequest(request: .friends, params: params, completion: completion)
    }
    
    func getPhotos(ownerId: Int, completion: @escaping ([VKPhoto]) -> Void) {
        let params: Parameters = [
            "album_id": "profile",
            "owner_id": "\(ownerId)",
            "extended": "1" //для получения лайков
        ]
        
        makeRequest(request: .photos, params: params, completion: completion)
    }
    
    func getAllPhotos(ownerId: String, completion: @escaping ([VKPhoto]) -> Void) {
        let params: Parameters = [
            "owner_id": ownerId
        ]
        
        makeRequest(request: .allPhotos, params: params, completion: completion)
    }
    
    func getUserInfo(userId: String, completion: @escaping ([VKUser]) -> Void) {
        let requestUrl = apiURL + ApiRequests.userInfo.rawValue
        let params: Parameters = [
            "access_token": token,
            "v": "5.103",
            "user_ids": userId,
            "fields": "photo_100,"
                + "status",
        ]
        
        AF.request(requestUrl, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedModel = try JSONDecoder().decode(VKUserResponse<VKUser>.self, from: data)
                        let responseData = decodedModel.response
//                        print("My response: \(responseData)")
                        completion(responseData)
                    } catch {
                        print("❌ \(error) ❌")
                    }
                case let .failure(error):
                    print("❌ \(error) ❌")
                }
        }
    }
}
