//
//  User.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: Name
    let dateOfBirth: DateOfBirth
    let email: String
    let picture: Picture
    let nationality: String

    enum CodingKeys: String, CodingKey {
        case name
        case dateOfBirth = "dob"
        case email
        case picture
        case nationality = "nat"
    }
}

// MARK: - Substructs
struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct DateOfBirth: Codable {
    let age: Int
}

struct Picture: Codable {
    let large: String
    let thumbnail: String
}

// MARK: - Display
extension User {
    var fullName: String {
        return "\(name.title) \(name.first) \(name.last)"
    }

    var age: String {
        return "\(dateOfBirth.age)"
    }

    var smallPictureUrl: String {
        return picture.thumbnail
    }

    var bigPictureUrl: String {
        return picture.large
    }

    var flag: String {
        return nationality.unicodeFlag
    }
}
