//
//  String+UnicodeFlag.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

extension String {
    var unicodeFlag: String {
        let base : UInt32 = 127397
        var s = ""
        unicodeScalars
            .compactMap { UnicodeScalar(base + $0.value) }
            .forEach { s.unicodeScalars.append($0) }
        return String(s)
    }
}
