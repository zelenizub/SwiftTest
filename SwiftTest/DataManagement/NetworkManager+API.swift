//
//  NetworkManager+API.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

// TODO extract to constants
let baseURL = "https://randomuser.me/api"

extension NetworkManager {
    public func getUserList(
        page: Int,
        results: Int,
        onResponse: UserListResponseHandler?,
        onError: ErrorHandler?
    ) {
        guard let url = URL(string: "\(baseURL)?page=\(page)&results=\(results)" ) else {
            debugPrint("🔴 Invalid auth URL!")
            return
        }
        get(url: url, onData: { data in
            do {
                let response = try JSONDecoder().decode(UserListResponse.self, from: data)
                onResponse?(response)
            } catch {
                debugPrint("🔴 Could not decode auth response!")
                onError?(NetworkError.unexpectedResponseFormat)
            }
        }) { (error) in
            onError?(error)
        }
    }
}
