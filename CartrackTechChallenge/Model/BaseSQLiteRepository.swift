//
//  BaseSQLiteRepository.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SQLite3

internal class BaseSQLiteRepository {
    internal func openDatabase(dbName: String) -> OpaquePointer? {
        let fileURL = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(dbName)
       
        var db: OpaquePointer?
        guard let url = fileURL else {
            NSLog("part1DbPath is nil.")
            return nil
        }
       
        if sqlite3_open(url.path, &db) == SQLITE_OK {
            NSLog("Successfully opened connection to database at \(url)")
            return db
        }
       
        return nil
    }
}
