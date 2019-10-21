//
//  UserListResponse.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

// https://randomuser.me/api?page=1&results=20

typealias UserListResponseHandler = ((UserListResponse) -> Void)

struct UserListResponse: Codable {
    let results: [User]
}
