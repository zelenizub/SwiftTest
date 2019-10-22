//
//  UserListViewModelTests.swift
//  SwiftTestTests
//
//  Created by Zeljko Ilic on 10/22/19.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest
@testable import SwiftTest

class UserListViewModelTests: XCTestCase {

    func testWhenInitializedThenEmptyUsers() {
        let spy = UserListViewModelDelegateSpy()
        let stub = UserAPIClientStub()
        let cut = UserListViewModel(delegate: spy, userAPIClient: stub)
        XCTAssertEqual(cut.users, [])
    }

    func testWhenFetchAndErrorThenPassedToDelegate() {
        let spy = UserListViewModelDelegateSpy()
        let error = NetworkError.unexpectedResponseFormat
        let stub = UserAPIClientStub(error: error)
        let cut = UserListViewModel(delegate: spy, userAPIClient: stub)
        cut.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(spy.fetchCompletedCalls, 0)
            XCTAssertEqual(spy.fetchFailedCalls, 1)
            XCTAssertEqual(spy.receivedError as? NetworkError, error)
        }
    }

    func testWhenFetchAndSuccessThenPassedToDelegate() {
        let spy = UserListViewModelDelegateSpy()
        let stub = UserAPIClientStub()
        let cut = UserListViewModel(delegate: spy, userAPIClient: stub)
        let expectation = XCTestExpectation(description: "Users fetch")
        cut.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(spy.fetchCompletedCalls, 1)
            XCTAssertEqual(spy.fetchFailedCalls, 0)
            XCTAssertNil(spy.receivedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenFetchAndSuccessThenCorrectUsersAndCurrentPage() {
        let spy = UserListViewModelDelegateSpy()
        let stub = UserAPIClientStub(pageToUsersMapping: [
            0 : [UserFixture.user1]
        ])
        let cut = UserListViewModel(delegate: spy, userAPIClient: stub)
        let expectation = XCTestExpectation(description: "Users fetch")
        cut.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(cut.currentPage, 1)
            XCTAssertEqual(cut.users, [UserFixture.user1])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenSecondFetchWhileFetchingThenIgnored() {
        let spy = UserListViewModelDelegateSpy()
        let stub = UserAPIClientStub(pageToUsersMapping: [
            0 : [UserFixture.user1],
            1 : [UserFixture.user2]
        ])
        let cut = UserListViewModel(delegate: spy, userAPIClient: stub)
        let expectation = XCTestExpectation(description: "Users fetch")
        cut.fetchUsers()
        cut.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(cut.currentPage, 1)
            XCTAssertEqual(cut.users, [UserFixture.user1])
            XCTAssertEqual(spy.fetchCompletedCalls, 1)
            XCTAssertEqual(spy.fetchFailedCalls, 0)
            XCTAssertNil(spy.receivedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenSecondFetchAndSuccessThenCorrectUsersAndCurrentPage() {
        let spy = UserListViewModelDelegateSpy()
        let stub = UserAPIClientStub(pageToUsersMapping: [
            0 : [UserFixture.user1],
            1 : [UserFixture.user2]
        ])
        let cut = UserListViewModel(delegate: spy, userAPIClient: stub)
        let expectation = XCTestExpectation(description: "Users fetch")
        cut.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cut.fetchUsers()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(cut.currentPage, 2)
            XCTAssertEqual(cut.users, [UserFixture.user1, UserFixture.user2])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

}
