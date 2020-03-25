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
    
    var token: String
    var userId: String
    
    init(token: String, userId: String) {
        self.token = token
        self.userId = userId
    }
    
    private func doRequest<ResponseType: Decodable>(token: String,
                                                    request: ApiRequests,
                                                    params inputParams: [String: Any],
                                                    type: ResponseType.Type,
                                                    method: HTTPMethod = .get,
                                                    completion: @escaping ([ResponseType]) -> Void) {
            let requestUrl = apiURL + request.rawValue
            let defaultParams: [String : Any] = [
                "access_token": token,
                "user_id": userId,
                "v": "5.103"
            ]
            let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
            
            AF.request(requestUrl, method: method, parameters: params)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case let .success(data):
    //                    print("📩📩📩 VKApi Response: 📩📩📩")
    //                    print(data)
                        
                        do {
                            let decodedModel = try JSONDecoder().decode(VKResponse<ResponseType>.self, from: data)
                            guard let responseData = decodedModel.response else {
                                return
                            }
                            completion(responseData.items)
                        } catch {
                            print("❌ \(error)")
                        }
                    case let .failure(error):
                        print(error)
                    }
        }
    }
    
    
    func getGroups(completion: @escaping ([VKCommunity]) -> Void) {
        let params = [
            "extended" : "1",
            "fields": "activity, description"
        ]
        
        doRequest(token: token, request: .groups, params: params, type: VKCommunity.self) { response in
            completion(response)
        }
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping ([VKCommunity]) -> Void) {
        let params = [
            "order": "name",
            "q" : groupName,
            "type": "group",
            "fields": "city, domain",
        ]
        
        doRequest(token: token, request: .groupsSearch, params: params, type: VKCommunity.self, completion: completion)
    }
    
    func getFriends(completion: @escaping ([VKFriend]) -> Void) {
        let params = [
            "user_id": userId,
            "order": "hints",
            "fields": "city,"
            + "photo_200_orig"
        ]
        
        doRequest(token: token, request: .friends, params: params, type: VKFriend.self, completion: completion)
    }
    
    func getPhotos(ownerId: Int, completion: @escaping ([VKPhoto]) -> Void) {
        let params = [
            "album_id": "profile",
            "owner_id": "\(ownerId)",
            "extended": "1" //для получения лайков
        ]
        
        doRequest(token: token, request: .photos, params: params, type: VKPhoto.self, completion: completion)
    }
    
    func getAllPhotos(ownerId: String, completion: @escaping ([VKPhoto]) -> Void) {
        let params = [
            "owner_id": ownerId
        ]
        
        doRequest(token: token, request: .allPhotos, params: params, type: VKPhoto.self, completion: completion)
    }
}
