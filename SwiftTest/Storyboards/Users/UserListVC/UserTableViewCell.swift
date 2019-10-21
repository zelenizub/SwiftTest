//
//  UserTableViewCell.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageAndNationalityLabel: UILabel!

    public func setup(with user: User) {
        fullNameLabel.text = user.fullName
        ageAndNationalityLabel.text = "\(user.age) years old, from \(user.flag)"
        picture.loadImage(from: user.smallPictureUrl)
    }
}
