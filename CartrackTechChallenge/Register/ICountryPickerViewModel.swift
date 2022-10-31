//
//  ICountryPickerViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 12/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal protocol ICountryPickerViewModel {
    // MARK: - Observable Variables
    var countryList: BehaviorRelay<[Country]> { get }
}
