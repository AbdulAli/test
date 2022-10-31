//
//  CountryRepository.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import SQLite3

internal class CountryRepository: BaseSQLiteRepository, ICountryRepository {
    
    // MARK: Private Attributesa
    private let createCountryTableString = """
                                    CREATE TABLE IF NOT EXISTS Country(
                                    Id INTEGER PRIMARY KEY NOT NULL,
                                    Name CHAR(255));
                                    """
    private let insertCountryString = "INSERT INTO Country (Name) VALUES (?);"
    private var db: OpaquePointer?
    
    init(dbName: String){
        super.init()
        
        self.db = openDatabase(dbName: dbName)
        self.createCountryTable()
        
        self.createCountryData()
    }
    
    internal func getCountryList() -> Observable<[Country]>{
        return Observable.create { observer in
            let countries = self.getCountries()
            observer.onNext(countries)
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    internal func getCountryName(id: Int) -> Observable<String> {
        return Observable.create { observer in
            let country = self.findCountry(id: id)
            
            observer.onNext(country)
            observer.onCompleted()
            
            return Disposables.create {}
        }
    }
    
    private func createCountryData() {
        for _ in 1...10 {
            let country_name = "name" + String(Int.random(in: 1..<700))
            self.insert(name: country_name as NSString)
        }
    }
    
    private func createCountryTable() {
        var createTableStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, createCountryTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                NSLog("\nCountry table created.")
            } else {
                NSLog("\nCountry table is not created.")
            }
        } else {
            NSLog("\nCountry TABLE statement is not prepared.")
        }

        sqlite3_finalize(createTableStatement)
    }
    
    private func insert(name: NSString){
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertCountryString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)
            sqlite3_step(insertStatement)
        }

        sqlite3_finalize(insertStatement)
    }
    
    private func getCountries() -> [Country]{
        let queryStatementString = "SELECT * FROM Country;"
        var queryStatement: OpaquePointer?
        var result = [Country]()

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)

                if let queryResultName = sqlite3_column_text(queryStatement, 1) {
                    let name = String(cString: queryResultName)
                    let country = Country(id: Int(id), name: name)
                    
                    result.append(country)
                }
            }
        }

        sqlite3_finalize(queryStatement)
        
        return result
    }
    
    private func checkIfTableIsEmpty() -> Bool{
        let queryStatementString = "SELECT * FROM Country;"
        var queryStatement: OpaquePointer?
        var isEmpty = false

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) != SQLITE_ROW {
                isEmpty = true
            }
        }

        sqlite3_finalize(queryStatement)
        
        return isEmpty
    }
    
    private func findCountry(id: Int) -> String {
        let queryStatementString = "SELECT Name FROM Country WHERE Id = \(id);"
        var queryStatement: OpaquePointer?
        var result = ""

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                 if let queryResultName = sqlite3_column_text(queryStatement, 0) {
                    result = String(cString: queryResultName)
                 }
            }
        }

        sqlite3_finalize(queryStatement)
        
        return result
    }
}
