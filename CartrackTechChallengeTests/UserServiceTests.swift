//
//  UserServiceTests.swift
//  CartrackTechChallengeTests
//
//  Created by Ricardo Correia on 14/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

//
//  CartrackTechChallengeTests.swift
//  CartrackTechChallengeTests
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

@testable import CartrackTechChallenge

import Mockingjay
import XCTest
import RxSwift

class UserServiceTests: XCTestCase {

    private var service: UserService?
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        let userRepository = UserRepository()
        self.service = UserService(with: userRepository)
    }

    func testGetUserListSuccess() {
        guard let service = self.service else {
            XCTFail("Error initializing service")
            return
        }
        
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get user list response")
        
        let utils = UnitTestingUtils()
        guard let data = utils.readJSON(path: "get_user_list") else {
            XCTFail()
            return
        }
        
        stub(everything, jsonData(data, status: 200))
        
        var userList:[User]?
        let getUserList = service.getUserList()
        getUserList.subscribe(
            onNext: { list in
                userList = list
                expectation?.fulfill()
                expectation = nil
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        guard let users = userList else {
            XCTFail("User list not filled")
            return
        }
        
        XCTAssertTrue(users.count == 2)
        
        let user1 = users[0]
        XCTAssertTrue(user1.name == "Leanne Graham")
        XCTAssertTrue(user1.username == "Bret")
        
        let user2 = users[1]
        XCTAssertTrue(user2.name == "Ervin Howell")
        XCTAssertTrue(user2.username == "Antonnete")
    }
    
    func testGetUserListError() {
        guard let service = self.service else {
            XCTFail("Error initializing service")
            return
        }
        
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get user list response")
        
        let utils = UnitTestingUtils()
        guard let data = utils.readJSON(path: "get_user_list_error") else {
            XCTFail()
            return
        }
        
        stub(everything, jsonData(data, status: 404))
        
        var error: Error?
        let getUserList = service.getUserList()
        getUserList.subscribe(
            onError: { e in
                error = e
                expectation?.fulfill()
                expectation = nil
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertNotNil(error)
    }
}
