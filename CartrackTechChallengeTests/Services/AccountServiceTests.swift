//
//  AccountServiceTests.swift
//  CartrackTechChallengeTests
//
//  Created by Ricardo Correia on 15/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

@testable import CartrackTechChallenge

import Mockingjay
import XCTest
import RxSwift


class AccountServiceTests: XCTestCase {
    
    private let DB_NAME = "test.sqlite"
    
    private var accountService: AccountService?
    private let disposeBag = DisposeBag()

    override func setUp() {
        let accountRepository = AccountRepository(dbName: DB_NAME)
        let countryRepository = CountryRepository(dbName: DB_NAME)
        
        self.accountService = AccountService(with: accountRepository, countryRepository: countryRepository)
    }
    
    override func tearDown() {
        let utils = UnitTestingUtils()
        _ =  utils.closeDatabase(dbName: DB_NAME)
    }
    
    func testRegisterSuccess() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get registration response")
        var result = false
        
        let register = self.accountService?.register(username: "test", password: "test", countryId: 1)
        register?.subscribe(
            onNext: { success in
                result = success
                expectation?.fulfill()
                expectation = nil
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(result)
    }
    
    func testRegisterError() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get registration response")
        var result = false
        
        let register = self.accountService?.register(username: "test", password: "test", countryId: 1)
        register?.subscribe(
            onCompleted: {
                let registerError = self.accountService?.register(username: "test", password: "test", countryId: 1)
                registerError?.subscribe(
                    onNext: { success in
                        result = success
                        expectation?.fulfill()
                        expectation = nil
                    }
                ).disposed(by: self.disposeBag)
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertFalse(result)
    }

    func testLoginSuccess() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get login response")
        var result = false
        
        let register = self.accountService?.register(username: "test", password: "test", countryId: 1)
        register?.subscribe(
            onCompleted: {
                let login = self.accountService?.login(username: "test", password: "test")
                login?.subscribe(
                    onNext: { success in
                        result = success
                        expectation?.fulfill()
                        expectation = nil
                    }
                ).disposed(by: self.disposeBag)
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(result)
    }
    
    func testLoginError() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get login response")
        var result = false
        
        let register = self.accountService?.register(username: "test", password: "test", countryId: 1)
        register?.subscribe(
            onCompleted: {
                let login = self.accountService?.login(username: "error", password: "fail")
                login?.subscribe(
                    onNext: { success in
                        result = success
                        expectation?.fulfill()
                        expectation = nil
                    }
                ).disposed(by: self.disposeBag)
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertFalse(result)
    }
    
    func testGetCountryList() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get country list response")
        var result = [Country]()
        
        let getCountryList = self.accountService?.getCountryList()
        getCountryList?.subscribe(
            onNext: { data in
                result = data
                expectation?.fulfill()
                expectation = nil
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(result.count == 10)
        XCTAssertTrue(result[0].name == "Portugal")
    }
    
    func testGetActiveUser() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get active user response")
        var result = ""
        
        guard let register = self.accountService?.register(username: "test", password: "test", countryId: 1),
            let login = self.accountService?.login(username: "test", password: "test") else {
                XCTFail("Error initializing observables")
                return
        }
        
        let observable = Observable.concat(register, login)
        observable.subscribe(
            onCompleted: {
                let getActiveUser = self.accountService?.getActiveUser()
                getActiveUser?.subscribe(
                    onNext: { data in
                        result = data.username
                        expectation?.fulfill()
                        expectation = nil
                    }
                ).disposed(by: self.disposeBag)
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(result == "test")
    }
    
    func testGetCountryName() {
        // Expectation that the saveDisease is updated
        var expectation: XCTestExpectation? = self.expectation(description: "Get country name response")
        var result = ""
        
        let getCountryName = self.accountService?.getCountryName(id: 2)
        getCountryName?.subscribe(
            onNext: { text in
                result = text
                expectation?.fulfill()
                expectation = nil
            }
        ).disposed(by: self.disposeBag)
        
        // wait until the expectation is complete
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(result == "Spain")
    }
}
