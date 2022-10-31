//
//  SwinjectStoryboard+Inject.swift
//  Turbu
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        
        // LoginViewController
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { r, c in
            c.loginViewModel = r.resolve(ILoginViewModel.self)
        }
        
        // RegisterViewController
        defaultContainer.storyboardInitCompleted(RegisterViewController.self) { r, c in
            c.registerViewModel = r.resolve(IRegisterViewModel.self)
        }
        
        // CountryPickerViewController
        defaultContainer.storyboardInitCompleted(CountryPickerViewController.self) { r, c in
            c.pickerViewModel = r.resolve(ICountryPickerViewModel.self)
        }
        
        // AccountViewController
        defaultContainer.storyboardInitCompleted(AccountViewController.self) { r, c in
            c.accountViewModel = r.resolve(IAccountViewModel.self)
        }
        
        // UserListViewController
        defaultContainer.storyboardInitCompleted(UserListViewController.self) { r, c in
            c.userListViewModel = r.resolve(IUserListViewModel.self)
        }
        
        // UserDetailsViewController
        defaultContainer.storyboardInitCompleted(UserDetailsViewController.self) { r, c in
           
        }

        InjectAppViewModels.init().assemble(container: defaultContainer)
        InjectAppServices.init().assemble(container: defaultContainer)
        InjectAppRepositories.init().assemble(container: defaultContainer)
    }
}
