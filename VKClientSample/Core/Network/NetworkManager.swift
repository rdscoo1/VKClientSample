//
//  NetworkManager.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 09.11.2021.
//  Copyright © 2021 Roman Khodukin. All rights reserved.
//

import Alamofire
import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func requestFriendsList(completion: @escaping (Result<Friend, Error>) -> Void)
}

class NetworkManager {

    //MARK: - Constants

    private let apiURL = "https://\(Constants.baseUrl)/method/"
    private let defaultParams: Parameters = [
        "access_token": Session.shared.token,
        "v": "5.103"
    ]

    // MARK: - Private methods

    private func makeRequest<ResponseType: Decodable>(
        apiPath: Constants.ApiPath,
        params inputParams: Parameters,
        httpMethod: Alamofire.HTTPMethod = .get,
        completion: @escaping (Result<[ResponseType], Error>) -> Void) {
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
                                completion(.success(responseData.items))
                            } else if
                                let errorCode = decodedModel.error?.errorCode,
                                let errorMsg = decodedModel.error?.errorMessage
                            {
                                print("❌ NetworkService \(apiPath.rawValue) error\n\(errorCode) \(errorMsg) ❌")
                            }
                        } catch {
                            print("❌ Decoding \(VKResponse<ResponseType>.self) failed ❌\n\(error)")
                        }
                    case let .failure(error):
                        print("❌ Alamofire error\n \(error) ❌")
                    }
                }
        }

}
