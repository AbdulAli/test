//
//  IAccountService.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift

internal protocol IAccountService {
    // MARK: - Functions
    func login(username: String, password: String) -> Observable<Bool>?
    func register(username: String, password: String, countryId: Int) -> Observable<Bool>?
    func getCountryList() -> Observable<[Country]>?
    func getActiveUser() -> Observable<(username: String, countryId: Int)>?
    func getCountryName(id: Int) -> Observable<String>?
}
