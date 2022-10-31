//
//  InjectAppServices.swift
//  Turbu
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Swinject

public class InjectAppServices: Assembly {
    public func assemble(container: Container) {

        // IUserService
        container.register(IUserService.self) { _ in
            let repository = container.resolve(IUserRepository.self)
            return UserService(with: repository)
        }
        
        // IAccountService
        container.register(IAccountService.self) { _ in
            let accountRepository = container.resolve(IAccountRepository.self)
            let countrytRepository = container.resolve(ICountryRepository.self)
            return AccountService(with: accountRepository, countryRepository: countrytRepository)
        }
    }
}
