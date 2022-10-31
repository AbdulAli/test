//
//  CountryPickerViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 12/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class CountryPickerViewModel: ICountryPickerViewModel {
    
    // MARK: - Observable Variables
    var countryList: BehaviorRelay<[Country]> = BehaviorRelay<[Country]>(value: [])
    
    // MARK: - Internal Attributes
    internal var accountService: IAccountService?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
         
    // MARK: - Default constructor
    init(with accountService: IAccountService?) {
        self.accountService = accountService
        
        let getCountryList = self.accountService?.getCountryList()
        getCountryList?.subscribe(
            onNext: { data in
                self.countryList.accept(data)
            }
        ).disposed(by: self.disposeBag)
    }
}
