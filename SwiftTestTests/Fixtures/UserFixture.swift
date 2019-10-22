//
//  UserFixture.swift
//  SwiftTestTests
//
//  Created by Zeljko Ilic on 10/22/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
@testable import SwiftTest

struct UserFixture {
    static let user1 = User(
        name: Name(title: "Mr.", first: "Emile1", last: "Scot1"),
        dateOfBirth: DateOfBirth(age: 69),
        email: "emile.scott@example.com",
        picture: Picture(
            large: "https://randomuser.me/api/portraits/men/68.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/68.jpg"
        ),
        nationality: "CA"
    )

    static let user2 = User(
        name: Name(title: "Mr.", first: "Emile2", last: "Scot2"),
        dateOfBirth: DateOfBirth(age: 69),
        email: "emile.scott@example.com",
        picture: Picture(
            large: "https://randomuser.me/api/portraits/men/68.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/68.jpg"
        ),
        nationality: "CA"
    )
}
