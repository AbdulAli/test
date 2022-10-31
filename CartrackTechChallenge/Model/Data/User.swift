//
//  User.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class User {
    internal var id: Int?
    internal var name: String?
    internal var username: String?
    internal var email: String?
    internal var phone: String?
    internal var website: String?
    internal var address: Address?
    internal var company: Company?
    
    init(data: JSON) {
        self.parseJsonData(data: data)
    }
    
    private func parseJsonData(data: JSON) {
        self.id = data["id"].int
        self.name = data["name"].string
        self.username = data["username"].string
        self.email = data["email"].string
        self.phone = data["phone"].string
        self.website = data["website"].string
        
        self.address = Address(data: data["address"])
        self.company = Company(data: data["company"])
    }
}
