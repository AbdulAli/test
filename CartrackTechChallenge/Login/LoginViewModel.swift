//
//  LoginViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class LoginViewModel: ILoginViewModel {
   
    // MARK: - Observable Variables
    internal var loginSuccess: BehaviorRelay<Bool?> = BehaviorRelay<Bool?>(value: nil)
    
    // MARK: - Internal Attributes
    internal var accountService: IAccountService?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
         
    // MARK: - Default constructor
    init(with accountService: IAccountService?) {
        self.accountService = accountService
    }
    
    internal func login(username: String, password: String) {
        let login = self.accountService?.login(username: username, password: password)
        login?.subscribe(
            onNext: { success in
                self.loginSuccess.accept(success)
            }
        ).disposed(by: self.disposeBag)
    }
}
