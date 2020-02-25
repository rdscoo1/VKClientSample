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
    
    
    func getGroups(completion: @escaping (String) -> Void) {
        let params = [
            "extended" : "1",
            "fields": "activity, description"
        ]
        
        doRequest(token: token, userId: userId, request: .groups, params: params, completion: completion)
    }
    
    func getSearchedGroups(groupName: String, completion: @escaping (String) -> Void) {
        let params = [
            "order": "name",
            "q" : groupName,
            "type": "group",
            "fields": "city, domain",
        ]
        
        doRequest(token: token, userId: userId, request: .groupsSearch, params: params, completion: completion)
    }
    
    func getFriends(completion: @escaping (String) -> Void) {
        let params = [
            "order": "name",
            "fields": "city, fomain"
        ]
        
        doRequest(token: token, userId: userId, request: .friends, params: params, completion: completion)
    }
    
    func getAllPhotos(completion: @escaping (String) -> Void) {
        doRequest(token: token, userId: userId, request: .allPhotos, params: [:], completion: completion)
    }
    
    
    private func doRequest(token: String, userId: String, request: ApiRequests, params inputParams: [String: Any], method: HTTPMethod = .get, completion: @escaping (String) -> Void) {
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
                   print("📩📩📩 VKApi Response: 📩📩📩")
                   print(response)
                case let .failure(error):
                    print(error)
                }
            })
    }
}
