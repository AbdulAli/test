//
//  Country.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation

internal class Country {
    internal var id: Int?
    internal var name: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
