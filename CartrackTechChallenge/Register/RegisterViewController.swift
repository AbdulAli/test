//
//  RegisterViewController.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

internal protocol PickerViewDelegate {
    func didSelectCountry(country: Country?)
}

internal class RegisterViewController: BaseViewController, PickerViewDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var registerTitle: UILabel!
    @IBOutlet weak var registerDescription: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var countryButton: UIButton!
    
    // MARK: - Internal Attributes
    internal var registerViewModel: IRegisterViewModel?
    
    // MARK: - Private Attributes
    private var selectedCountryId: Int?
    private let disposeBag = DisposeBag()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupButton(to: false)
        self.fillLocalizableStrings()
        self.configureTextFields()
        self.bindObservableVariables()
        
        let name = "ali" + String(Int.random(in: 1..<98000)) + String(Int.random(in: 1..<5400))
        self.registerViewModel?.register(username: name, password: name, countryId: 1)
    }
    
    private func fillLocalizableStrings() {
        self.registerTitle.text = "registration_title".localized()
        self.registerDescription.text = "registration_description".localized()
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
    
    
    /// Bind to ViewModel's observable variables to update view content
    private func bindObservableVariables() {
        self.registerViewModel?.registrationSuccess.asObservable()
            .bind { registrationSuccess in
                guard let success = registrationSuccess else { return }
                if success {
                    self.presentSuccessAlertController()
                } else {
                    self.presentErrorAlertController()
                }
            }.disposed(by: disposeBag)
    }
    
    func setupButton(to state: Bool) {
        // Checks for the ok button's current state and updates it accordingly
        registerButton.alpha = state ? 1.0 : 0.25
        registerButton.isEnabled = state
    }
    
    @objc func textFieldDidChange() {
        self.validateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? CountryPickerViewController else {
            return
        }
       
        viewController.delegate = self
    }
    
    func didSelectCountry(country: Country?) {
        self.countryButton.setTitle("  \(country?.name ?? "")", for: .normal)
        self.selectedCountryId = country?.id
        self.validateData()
    }
    
    @IBAction func didPressRegisterButton(_ sender: Any) {
        self.registerViewModel?.register(username: username.text, password: password.text, countryId: selectedCountryId)
    }
    
    private func validateData() {
        if username.text != "" && password.text != "" && selectedCountryId != nil {
            self.setupButton(to: true)
        } else {
            self.setupButton(to: false)
        }
    }
    
    private func presentSuccessAlertController() {
        let alert = UIAlertController(title: "registration_successfull".localized(),
                                      message: "welcome".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    private func presentErrorAlertController() {
        let alert = UIAlertController(title: "registration_failed".localized(),
                                      message: "an_error_has_occurred".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
