//
//  IUserListViewModel.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal protocol IUserListViewModel {
    
    // MARK: - Observable Variables
    var userList: BehaviorRelay<[User]> { get }
    
    // MARK: - Functions
    func loadData()
}
