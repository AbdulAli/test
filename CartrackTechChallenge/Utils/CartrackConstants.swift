//
//  CartrackConstants.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation

internal enum CustomError: Error {
    case emptyDataSet
}

internal class CartrackConstants {
    internal static let DB_NAME = "cartrack.sqlite"
    internal static let GET_USERS = "https://jsonplaceholder.typicode.com/users"
}
