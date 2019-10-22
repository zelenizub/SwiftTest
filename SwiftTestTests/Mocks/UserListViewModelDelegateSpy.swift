//
//  UserListViewModelDelegateSpy.swift
//  SwiftTestTests
//
//  Created by Zeljko Ilic on 10/22/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
@testable import SwiftTest

class UserListViewModelDelegateSpy: UserListViewModelDelegate {
    var fetchCompletedCalls = 0
    var fetchFailedCalls = 0
    var receivedError: Error?

    func onFetchCompleted() {
        fetchCompletedCalls += 1
    }

    func onFetchFailed(with error: Error) {
        fetchFailedCalls += 1
        receivedError = error
    }
}
