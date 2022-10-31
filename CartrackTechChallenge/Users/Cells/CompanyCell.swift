//
//  CompanyCell.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit

internal class CompanyCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var worksAtLabel: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var catchPhrase: UILabel!
    @IBOutlet weak var bs: UILabel!
    
    // MARK: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
