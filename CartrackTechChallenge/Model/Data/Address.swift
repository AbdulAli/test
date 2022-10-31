//
//  Address.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class Address {
    internal var street: String?
    internal var suite: String?
    internal var city: String?
    internal var zipcode: String?
    internal var geo: Geo?
    
    init(data: JSON) {
        self.parseJsonData(data: data)
    }
    
    private func parseJsonData(data: JSON) {
        self.street = data["street"].string
        self.suite = data["suite"].string
        self.city = data["city"].string
        self.zipcode = data["zipcode"].string
        
        self.geo = Geo(data: data["geo"])
    }
}
