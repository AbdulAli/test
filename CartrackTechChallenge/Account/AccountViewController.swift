//
//  AccountViewController.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 14/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

internal class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var dismissButton: UIBarButtonItem!
    
    // MARK: - Internal Attributes
    internal var accountViewModel: IAccountViewModel?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissButton.title = "dismiss".localized()
        self.bindObservableVariables()
        self.accountViewModel?.loadData()
    }
    
    /// Bind to ViewModel's observable variables to update view content
    private func bindObservableVariables() {
        self.accountViewModel?.username.asObservable()
            .bind { text in
                let usernameImg = UIImage(named: "username") ?? UIImage()
                self.username.set(image: usernameImg, with: text, width: 20, height: 20)
            }.disposed(by: disposeBag)
        
        self.accountViewModel?.country.asObservable()
            .bind { text in
                let countryImg = UIImage(named: "country") ?? UIImage()
                self.country.set(image: countryImg, with: text, width: 25, height: 25)
            }.disposed(by: disposeBag)
    }
    
    
    @IBAction func didPressDismissButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
