//
//  RegisterViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class RegisterViewModel: IRegisterViewModel {
    
    // MARK: - Observable Variables
    internal var registrationSuccess: BehaviorRelay<Bool?> = BehaviorRelay<Bool?>(value: nil)
    
    // MARK: - Internal Attributes
    internal var accountService: IAccountService?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
         
    // MARK: - Default constructor
    init(with accountService: IAccountService?) {
        self.accountService = accountService
    }
    
    internal func register(username: String?, password: String?, countryId: Int?) {
        guard let username = username, let password = password, let countryId = countryId else {
            self.registrationSuccess.accept(false)
            return
        }
        
        let register = self.accountService?.register(username: username, password: password, countryId: countryId)
        register?.subscribe(
            onNext: { success in
                self.registrationSuccess.accept(success)
            }
        ).disposed(by: self.disposeBag)
    }
}
