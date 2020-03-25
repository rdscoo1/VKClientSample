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
    
    
    func getGroups(completion: @escaping (Result<VKResponse<VKCommunity>, Error>) -> Void) {
        let params = [
            "extended" : "1",
            "fields": "activity, description"
        ]
        
        doRequest(token: token, userId: userId, request: .groups, params: params, completion: completion)
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping (Result<VKResponse<VKCommunity>, Error>) -> Void) {
        let params = [
            "order": "name",
            "q" : groupName,
            "type": "group",
            "fields": "city, domain",
        ]
        
        doRequest(token: token, userId: userId, request: .groupsSearch, params: params, completion: completion)
    }
    
    func getFriends(completion: @escaping (Result<VKResponse<VKFriend>, Error>) -> Void) {
        let params = [
            "order": "name",
            "fields": "city,"
            + "photo_200_orig"
        ]
        
        doRequest(token: token, userId: userId, request: .friends, params: params, completion: completion)
    }
    
    func getPhotos(ownerId: Int, completion: @escaping (Result<VKResponse<VKPhoto>, Error>) -> Void) {
        let params = [
            "album_id": "profile",
            "owner_id": "\(ownerId)",
            "extended": "1" //для получения лайков
        ]
        
        doRequest(token: token, userId: userId, request: .photos, params: params, completion: completion)
    }
    
    func getAllPhotos(ownerId: String, completion: @escaping (Result<VKResponse<VKPhoto>, Error>) -> Void) {
        let params = [
            "owner_id": ownerId
        ]
        
        doRequest(token: token, userId: userId, request: .allPhotos, params: params, completion: completion)
    }
    
    
    private func doRequest<ResponseType: Decodable>(token: String,
                                                    userId: String,
                                                    request: ApiRequests,
                                                    params inputParams: [String: Any],
                                                    method: HTTPMethod = .get,
                                                    completion: @escaping (Result<ResponseType, Error>) -> Void) {
        let requestUrl = apiURL + request.rawValue
        let defaultParams: [String : Any] = [
            "access_token": token,
            "user_id": userId,
            "v": "5.103"
        ]
        let params = defaultParams.merging(inputParams, uniquingKeysWith: { currentKey, _ in currentKey })
        
        AF.request(requestUrl, method: method, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
//                    print("📩📩📩 VKApi Response: 📩📩📩")
//                    print(response)
                    guard let responseData = response.data else {
                        return
                    }
                    do {
                        let decodedModel = try JSONDecoder().decode(ResponseType.self, from: responseData)
                        completion(.success(decodedModel))
                    } catch {
                        print("❌ \(error)")
                    }
                case let .failure(error):
                    print(error)
                }
            })
    }
}
