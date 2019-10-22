//
//  NetworkManager.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

typealias DataHandler = ((Result<Data, Error>) -> Void)

enum NetworkError: Error {
    case unexpectedResponseFormat
}

class NetworkManager {

    // MARK: - Singleton
    static let shared = NetworkManager()

    // MARK: - Constants
    let timeout = 60.0 //1min

    // MARK: - API
    public func get(url: URL, onCompletion: DataHandler?) {
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: timeout
        )
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error { onCompletion?(.failure(error)) }
            else if let data = data { onCompletion?(.success(data)) }
            }.resume()
    }
}
