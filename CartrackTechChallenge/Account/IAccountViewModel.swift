//
//  IAccountViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 14/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxCocoa

internal protocol IAccountViewModel {
    // MARK: - Observable Variables
    var username: BehaviorRelay<String> { get }
    var country: BehaviorRelay<String> { get }
    
    // MARK: - Functions
    func loadData()
}
