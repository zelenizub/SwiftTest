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
    email: "emile.scott@example.com",
    picture: Picture(
        large: "https://randomuser.me/api/portraits/men/68.jpg",
        thumbnail: "https://randomuser.me/api/portraits/thumb/men/68.jpg"
    ),
    nationality: "CA"
)

class UserListVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var table: UITableView!

    // MARK: - Properties
    private var selectedUser: User?
    private var users = [User]() {
        didSet {
            table.reloadData()
        }
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.register(
            UINib(nibName: UserTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: UserTableViewCell.reuseIdentifier
        )
        fetchUsers(showSpinner: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? UserInfoVC {
            guard let selectedUser = selectedUser else {
                debugPrint("🔴 Unexpected nil selectedUser!")
                return
            }
            destination.setup(with: selectedUser)
            self.selectedUser = nil
        }
    }

    // MARK: - Utils
    private func fetchUsers(showSpinner: Bool) {
        // TODO: implement
        users = [dummyUser, dummyUser, dummyUser]
    }
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension UserListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedUser = users[indexPath.row]
        // TODO: extract segue
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
}
