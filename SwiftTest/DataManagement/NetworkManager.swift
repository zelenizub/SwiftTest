//
//  NetworkManager.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

typealias ErrorHandler = ((Error) -> Void)
typealias DataHandler = ((Data) -> Void)

enum NetworkError: Error {
    case unexpectedResponseFormat
}

class NetworkManager {

    // MARK: - Singleton
    static let shared = NetworkManager()

    // MARK: - Constants
    let timeout = 60.0 //1min

    // TODO: use result

    // MARK: - API
    public func get(url: URL, onData: DataHandler?, onError: ErrorHandler?) {
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: timeout
        )
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error { onError?(error) }
            else if let data = data { onData?(data) }
            }.resume()
    }
}
