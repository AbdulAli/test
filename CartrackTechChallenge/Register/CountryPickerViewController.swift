//
//  CountryPickerViewController.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

internal class CountryPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    // MARK: IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // MARK: Internal Attributes
    internal var pickerViewModel: ICountryPickerViewModel?
    internal var delegate: PickerViewDelegate?
    internal var countries: [Country]?
    
    //MARK: - Private Attributes
    private var disposeBag = DisposeBag()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButton.title = "save".localized()
        self.cancelButton.title = "cancel".localized()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.bindObservableVariables()
    }
    
    private func bindObservableVariables() {
        self.pickerViewModel?.countryList.asObservable()
            .bind { list in
                self.countries = list
                self.pickerView.reloadAllComponents()
            }.disposed(by: disposeBag)
    }
    
    @IBAction func didPressSaveButton(_ sender: Any) {
        let index = pickerView.selectedRow(inComponent: 0)
        self.delegate?.didSelectCountry(country: countries?[index])
        self.dismiss(animated: true)
    }
    
    @IBAction func didPressCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - PickerView delegate and datasource
extension CountryPickerViewController {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries?[row].name
    }
}
