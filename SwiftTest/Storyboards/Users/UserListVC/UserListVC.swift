//
//  UserListVC.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

let dummyUser = User(
    name: Name(title: "Mr.", first: "Emile", last: "Scot"),
    dateOfBirth: DateOfBirth(age: 69),
    picture: Picture(
        large: "https://randomuser.me/api/portraits/men/68.jpg",
        thumbnail: "https://randomuser.me/api/portraits/thumb/men/68.jpg"
    ),
    nationality: "CA"
)

class UserListVC: UIViewController {

    @IBOutlet weak var table: UITableView!

    private var users = [User]() {
        didSet {
            table.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.register(
            UINib(nibName: UserTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: UserTableViewCell.reuseIdentifier
        )
        fetchUsers(showSpinner: true)
    }

    private func fetchUsers(showSpinner: Bool) {
        // TODO: implement
        users = [dummyUser, dummyUser, dummyUser]
    }
}

extension UserListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            debugPrint("🔴 Could not dequeue user cell!")
            return UITableViewCell()
        }
        cell.setup(with: users[indexPath.row])
        return cell
    }
}
