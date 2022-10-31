//
//  UserDetailsMainCell.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit

internal class UserDetailsMainCell: UITableViewCell{
    
     //MARK: - IBOutlets
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var email: UILabel!
    
    // MARK: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
