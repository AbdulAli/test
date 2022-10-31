//
//  ILoginViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxCocoa

internal protocol ILoginViewModel {
    // MARK: - Observable Variables
    var loginSuccess: BehaviorRelay<Bool?> { get }
    
    // MARK: Functions
    func login(username: String, password: String)
}
