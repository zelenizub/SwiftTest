//
//  UserAPIClientStub.swift
//  SwiftTestTests
//
//  Created by Zeljko Ilic on 10/22/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
@testable import SwiftTest

struct UserAPIClientStub: UserAPIClient {
    let error: Error?
    let pageToUsersMapping: [Int: [User]]

    init(error: Error? = nil, pageToUsersMapping: [Int: [User]] = [:]) {
        self.error = error
        self.pageToUsersMapping = pageToUsersMapping
    }

    func getUserList(page: Int, results: Int, onCompletion: UserListResponseHandler?) {
        if let error = error {
            onCompletion?(.failure(error))
        } else {
            onCompletion?(.success(UserListResponse(results: pageToUsersMapping[page] ?? [])))
        }
    }
}
