//
//  IAccountRepository.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift

internal protocol IAccountRepository {
    func login(username: String, password: String) -> Observable<Bool>
    func register(username: String, password: String, countryId: Int) -> Observable<Bool>
    func getCurrentUser() -> Observable<(username: String, countryId: Int)>
}
