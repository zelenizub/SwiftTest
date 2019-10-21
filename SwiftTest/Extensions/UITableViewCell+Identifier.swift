//
//  UITableViewCell+Identifier.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit

protocol Reuseable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reuseable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
