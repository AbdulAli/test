//
//  ViewController.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var loginDescription: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Internal Attributes
    internal var registerViewModel: IRegisterViewModel?
    
    // MARK: - Internal Attributes
    internal var loginViewModel: ILoginViewModel?
    
    internal var accountRepository: IAccountRepository?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillLocalizableStrings()
        self.setupButton(to: false)        
        self.configureTextFields()
        self.bindObservableVariables()
        self.registerButton.sendActions(for: .touchUpInside)
        //self.loginViewModel?.login(username: username.text ?? "ali", password: password.text ?? "ali")
        
    }
    
    private func fillLocalizableStrings() {
        self.loginTitle.text = "login_title".localized()
        self.loginDescription.text = "login_description".localized()
        self.loginButton.setTitle("login_title".localized(), for: .normal)
        self.registerButton.setTitle("registration_title".localized(), for: .normal)
    }
    
    private func configureTextFields() {
        username.placeholder = "username_placeholder".localized()
        username.delegate = self
        username.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        password.placeholder = "password_placeholder".localized()
        password.delegate = self
        password.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        password.isSecureTextEntry = true
    }
    
    private func bindObservableVariables() {
        self.loginViewModel?.loginSuccess.asObservable()
            .bind { loginSuccess in
                guard let success = loginSuccess else { return }
                if success {
                    self.launchUserListViewController()
                } else {
                    self.presentAlertController()
                }
            }.disposed(by: disposeBag)
        
        self.registerViewModel?.registrationSuccess.asObservable()
            .bind { registrationSuccess in
                guard let success = registrationSuccess else { return }
                if success {
                    self.presentAlertController()
                } else {
                    self.presentAlertController()
                }
            }.disposed(by: disposeBag)
    }
    
    func setupButton(to state: Bool) {
        // Checks for the ok button's current state and updates it accordingly
        loginButton.alpha = state ? 1.0 : 0.25
        loginButton.isEnabled = state
        
    }
    
    @objc func textFieldDidChange() {
        if username.text != "" && password.text != "" {
            self.setupButton(to: true)
        } else {
            self.setupButton(to: false)
        }
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        self.loginViewModel?.login(username: username.text ?? "", password: password.text ?? "")
    }
    
    private func launchUserListViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "UserListNavigationController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
    
    private func presentAlertController() {
        let alert = UIAlertController(title: "login_failed".localized(),
                                      message: "login_incorrect_username".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

