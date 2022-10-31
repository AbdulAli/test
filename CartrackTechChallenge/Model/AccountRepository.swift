//
//  AccountRepository.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import SQLite3

internal class AccountRepository: BaseSQLiteRepository, IAccountRepository {
    
    // MARK: Private Attributesa
    private let createAccountTableString = """
                                    CREATE TABLE IF NOT EXISTS Account(
                                    Id INTEGER PRIMARY KEY,
                                    CountryId INTEGER NOT NULL,
                                    Active INTEGER,
                                    Username CHAR(255),
                                    Password CHAR(255));
                                    """
    private let insertAccountString = "INSERT INTO Account (CountryId, Active, Username, Password) VALUES (?, ?, ?, ?);"
    private var db: OpaquePointer?
    
    init(dbName: String){
        super.init()
        
        self.db = openDatabase(dbName: dbName)
        self.createAccountTable()
    }
    
    internal func login(username: String, password: String) -> Observable<Bool> {
        return Observable.create { observer in
            let success = self.validateLoginInfo(username: username, password: password)
            
            observer.onNext(success)
            observer.onCompleted()
           
            return Disposables.create {}
        }
    }
    
    internal func register(username: String, password: String, countryId: Int) -> Observable<Bool> {
        return Observable.create { observer in
            var success: Bool?
            
            for _ in 1...7 {
                let name = "ali" + String(Int.random(in: 1..<98000)) + String(Int.random(in: 1..<5400))
                self.usernameExists(username: name)
            }
            
            success = true
           
            observer.onNext(success ?? false)
            observer.onCompleted()
           
            return Disposables.create {}
        }
    }
    
    func getCurrentUser() -> Observable<(username: String, countryId: Int)> {
        return Observable.create { observer in
            let user = self.getActiveUser()
            
            observer.onNext(user)
            observer.onCompleted()
           
            return Disposables.create {}
        }
    }
    
    private func createAccountTable() {
        var createTableStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, createAccountTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                NSLog("\nAccount table created.")
            } else {
                NSLog("\nAccount table is not created.")
            }
        } else {
            NSLog("\nCREATE TABLE statement is not prepared.")
        }

        sqlite3_finalize(createTableStatement)
    }
    
    private func insert(username: NSString, password: NSString, countryId: Int32) -> Bool{
        var insertStatement: OpaquePointer?
        var result = false

        if sqlite3_prepare_v2(db, insertAccountString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, countryId)
            sqlite3_bind_int(insertStatement, 2, 0)
            sqlite3_bind_text(insertStatement, 3, username.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, password.utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                result = true
            }
        }

        sqlite3_finalize(insertStatement)
        
        return result
    }
    
    private func usernameExists(username: String) -> Bool {
        let queryStatementString = "SELECT * FROM Account WHERE Username='\(username)';"
        var queryStatement: OpaquePointer?
        var result = false

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                result = true
            }
        }

        sqlite3_finalize(queryStatement)
        
        return result
    }
    
    private func validateLoginInfo(username: String, password: String) -> Bool {
        let queryStatementString = "SELECT * FROM Account WHERE Username='\(username)' AND Password = '\(password)';"
        var queryStatement: OpaquePointer?
        var result = false

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                result = true
                let previousUser = self.getActiveUser()
                self.changeUserState(username: previousUser.username, active: 0)
                self.changeUserState(username: username, active: 1)
            }
        }

        sqlite3_finalize(queryStatement)
        
        return result
    }
    
    private func getActiveUser() -> (username: String, countryId: Int) {
        let queryStatementString = "SELECT Username, CountryId FROM Account WHERE Active = 1;"
        var queryStatement: OpaquePointer?
        var username = ""
        var countryId = 0

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                if let queryResultName = sqlite3_column_text(queryStatement, 0) {
                    username = String(cString: queryResultName)
                }
                
                countryId = Int(sqlite3_column_int(queryStatement, 1))
            }
        }

        sqlite3_finalize(queryStatement)
        
        return (username, countryId)
    }
    
    private func changeUserState(username: String, active: Int) {
        let queryStatementString = "UPDATE Account SET Active = \(active) WHERE Username = '\(username)';"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_step(queryStatement)
        }

        sqlite3_finalize(queryStatement)
    }
}
