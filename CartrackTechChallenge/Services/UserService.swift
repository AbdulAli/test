//
//  UserService.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

internal class UserService: IUserService {
    
    // MARK: - Internal Attributes
    internal var userRepository: IUserRepository?
    
    // MARK: - Private Attributes
    private let disposeBag = DisposeBag()
    
    // MARK: - Default constructor
    init(with userRepository: IUserRepository?) {
        self.userRepository = userRepository
    }
    
    internal func getUserList() -> Observable<[User]> {
        return Observable.create { observer in
            let getUserList = self.userRepository?.getUserList()
            getUserList?.subscribe(
                onNext: { jsonData in
                    let userList = self.buildUserList(jsonData)
                    
                    observer.onNext(userList)
                    observer.onCompleted()
                },
                onError: { error in
                    observer.onError(error)
                }
            ).disposed(by: self.disposeBag)
           
            return Disposables.create {}
        }
    }
    
    private func buildUserList(_ jsonData: JSON?) -> [User] {
        var userList: [User] = []
        jsonData?.array?.forEach { user in
            let convertedUser = User(data: user)
            userList.append(convertedUser)
        }
        
        return userList
    }
}
