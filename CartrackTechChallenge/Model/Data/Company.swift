//
//  Company.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class Company {
    internal var name: String?
    internal var catchPhrase: String?
    internal var bs: String?
    
    init(data: JSON) {
        self.parseJsonData(data: data)
    }
    
    private func parseJsonData(data: JSON) {
        self.name = data["name"].string
        self.catchPhrase = data["catchPhrase"].string
        self.bs = data["bs"].string
    }
}

