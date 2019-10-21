//
//  String+UnicodeFlagTests.swift
//  SwiftTestTests
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest
@testable import SwiftTest

class String_UnicodeFlagTests: XCTestCase {

    func testWhenNationalityThenCorrectFlag() {
        XCTAssertEqual("RS".unicodeFlag, "🇷🇸")
        XCTAssertEqual("CH".unicodeFlag, "🇨🇭")
    }

    func testWhenEmptyThenEmpty() {
        XCTAssertEqual("".unicodeFlag, "")
    }

    func testWhenInvalidThenNoThrow() {
        XCTAssertNoThrow("a".unicodeFlag)
        XCTAssertNoThrow("1234".unicodeFlag)
        XCTAssertNoThrow("!".unicodeFlag)
    }
}
