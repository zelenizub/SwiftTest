//
//  UserListVC.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

// TODO: remove
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

    // MARK: - Constants
    let loadingCellID = "LoadingCell"
    let infoSegueID = "goToInfo"

    // MARK: - IBOutlets
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    // MARK: - Properties
    private lazy var viewModel = {
        UserListViewModel(delegate: self, userAPIClient: NetworkManager.shared)
    }()
    private var selectedUser: User?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.register(
            UINib(nibName: UserTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: UserTableViewCell.reuseIdentifier
        )
        table.register(
            UINib(nibName: UserTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: UserTableViewCell.reuseIdentifier
        )
        table.register(
            UINib(nibName: loadingCellID, bundle: nil),
            forCellReuseIdentifier: loadingCellID
        )
        if viewModel.currentCount == 0 {
            spinner.isHidden = false
            table.isHidden = true
        }
    }

    // MARK: - Segues
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
}

// MARK: - UITableViewDataSource
extension UserListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingCell(for: indexPath) {
            return table.dequeueReusableCell(withIdentifier: loadingCellID, for: indexPath)
        }
        guard let cell = table.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            debugPrint("🔴 Could not dequeue user cell!")
            return UITableViewCell()
        }
        cell.setup(with: viewModel.users[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UserListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedUser = viewModel.users[indexPath.row]
        performSegue(withIdentifier: infoSegueID, sender: self)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension UserListVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
          viewModel.fetchUsers()
        }
    }
}

// MARK: - UserListViewModelDelegate
extension UserListVC: UserListViewModelDelegate {
    func onFetchCompleted() {
        spinner.isHidden = true
        table.isHidden = false
        table.reloadData()
    }

    func onFetchFailed(with error: String) {
        spinner.isHidden = true
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - IndexPath Utils
private extension UserListVC {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
}
