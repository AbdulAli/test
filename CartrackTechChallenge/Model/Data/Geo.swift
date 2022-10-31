//
//  Geo.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class Geo {
    internal var latitude: Double?
    internal var longitude: Double?
    
    init(data: JSON) {
        self.parseJsonData(data: data)
    }
    
    private func parseJsonData(data: JSON) {
        self.latitude = Double(data["lat"].string ?? "")
        self.longitude = Double(data["lng"].string ?? "")
    }
}

