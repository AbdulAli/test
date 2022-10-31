//
//  AccountViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 14/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class AccountViewModel: IAccountViewModel {
    
    // MARK: - Observable Variables
    internal var username: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    internal var country: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    // MARK: - Internal Attributes
    internal var accountService: IAccountService?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
         
    // MARK: - Default constructor
    init(with accountService: IAccountService?) {
        self.accountService = accountService
    }
    
    internal func loadData() {
        let getActiveUser = self.accountService?.getActiveUser()
        getActiveUser?.subscribe(
            onNext: { data in
                self.username.accept(data.username)
                self.getCountryName(id: data.countryId)
            }
        ).disposed(by: self.disposeBag)
    }
    
    private func getCountryName(id: Int) {
        let getCountryName = self.accountService?.getCountryName(id: id)
        getCountryName?.subscribe(
            onNext: { text in
                self.country.accept(text)
            }
        ).disposed(by: self.disposeBag)
    }
}
