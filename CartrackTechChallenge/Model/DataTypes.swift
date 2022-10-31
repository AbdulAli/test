//
//  DataTypes.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 12/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation

internal enum Navigation {
    case success
    case error
}

internal struct AccountData {
    internal var username: String?
    internal var country: String?
}
