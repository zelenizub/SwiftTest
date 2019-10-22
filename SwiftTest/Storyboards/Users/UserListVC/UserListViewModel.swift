//
//  UserListViewModel.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

protocol UserListViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with error: Error)
}

class UserListViewModel {
    // MARK: - Constants
    private let pageSize = 10

    // MARK: - Properties
    private weak var delegate: UserListViewModelDelegate?
    private var userAPIClient: UserAPIClient!
    private var isFetching = false
    private(set) var currentPage = 0
    private(set) var totalCount = 0
    private(set) var users = [User]()

    // MARK: - Init
    init(delegate: UserListViewModelDelegate, userAPIClient: UserAPIClient) {
        self.delegate = delegate
        self.userAPIClient = userAPIClient
    }

    // MARK: - Utils
    var currentCount: Int {
        return users.count
    }

    func fetchUsers() {
        guard !isFetching else { return }
        isFetching = true
        userAPIClient.getUserList(page: currentPage, results: pageSize) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.currentPage += 1
                    // Since the https://randomuser.me/api doesn't return the total value,
                    // we're always setting it to one page after the last loaded
                    self.totalCount = (self.currentPage + 1) * self.pageSize
                    self.isFetching = false
                    self.users.append(contentsOf: response.results)
                    self.delegate?.onFetchCompleted()
                case let .failure(error):
                    self.isFetching = false
                    self.delegate?.onFetchFailed(with: error)
                }
            }
        }
    }
}
