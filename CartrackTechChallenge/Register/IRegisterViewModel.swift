//
//  IRegisterViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

internal protocol IRegisterViewModel {
    
    // MARK: - Observable Variables
    var registrationSuccess: BehaviorRelay<Bool?> { get }
    
    // MARK: - Functions
    func register(username: String?, password: String?, countryId: Int?)
}
