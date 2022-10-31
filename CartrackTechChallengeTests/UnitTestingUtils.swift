//
//  UnitTestingUtils.swift
//  CartrackTechChallengeTests
//
//  Created by Ricardo Correia on 14/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

@testable import CartrackTechChallenge
import Foundation

internal class UnitTestingUtils {
    internal func readJSON(path: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: path, ofType: "json") else {
            return nil
        }
        
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }

    internal func closeDatabase(dbName: String) -> Bool {
        let fileURL = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(dbName)
        
        guard let url = fileURL else {
            return false
        }
        
        do {
            try FileManager.default.removeItem(at:url)
        } catch {
             return false
        }
        
        return true
    }
}
