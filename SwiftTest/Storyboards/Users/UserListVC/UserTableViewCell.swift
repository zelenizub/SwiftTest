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
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!

    public func setup(with user: User) {
        fullNameLabel.text = user.fullName
        ageLabel.text = user.age
        nationalityLabel.text = user.flag
        picture.loadImage(from: user.smallPictureUrl)
    }
}
