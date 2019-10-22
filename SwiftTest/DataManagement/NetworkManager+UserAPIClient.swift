//
//  NetworkManager+UserAPIClient.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

let baseURL = "https://randomuser.me/api"

protocol UserAPIClient {
    func getUserList(
        page: Int,
        results: Int,
        onCompletion: UserListResponseHandler?
    )
}

extension NetworkManager: UserAPIClient {
    func getUserList(
        page: Int,
        results: Int,
        onCompletion: UserListResponseHandler?
    ) {
        guard let url = URL(string: "\(baseURL)?page=\(page)&results=\(results)" ) else {
            debugPrint("🔴 Invalid auth URL!")
            return
        }
        get(url: url) { result in
            switch result {
            case let .success(data):
                do {
                    let response = try JSONDecoder().decode(UserListResponse.self, from: data)
                    onCompletion?(.success(response))
                } catch {
                    debugPrint("🔴 Could not decode auth response!")
                    onCompletion?(.failure(NetworkError.unexpectedResponseFormat))
                }
            case let .failure(error):
                onCompletion?(.failure(error))
            }
        }
    }
}
