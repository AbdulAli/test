//
//  AddressCell.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit
import MapKit

internal class AddressCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
