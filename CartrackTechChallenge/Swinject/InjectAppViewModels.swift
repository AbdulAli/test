//
//  InjectAppViewModels.swift
//  Turbu
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Swinject

public class InjectAppViewModels: Assembly {
    public func assemble(container: Container) {

        // ILoginViewModel
        container.register(ILoginViewModel.self) { _ in
            let accountService = container.resolve(IAccountService.self)
            return LoginViewModel(with: accountService)
        }
        
        // IRegisterViewModel
        container.register(IRegisterViewModel.self) { _ in
            let accountService = container.resolve(IAccountService.self)
            return RegisterViewModel(with: accountService)
        }
        
        // ICountryPickerViewModel
        container.register(ICountryPickerViewModel.self) { _ in
            let accountService = container.resolve(IAccountService.self)
            return CountryPickerViewModel(with: accountService)
        }
        
        // IAccountViewModel
        container.register(IAccountViewModel.self) { _ in
            let accountService = container.resolve(IAccountService.self)
            return AccountViewModel(with: accountService)
        }
        
        // IUserListViewModel
        container.register(IUserListViewModel.self) { _ in
            let userService = container.resolve(IUserService.self)
            return UserListViewModel(with: userService)
        }
    }
}
