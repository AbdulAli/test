//
//  UserRepository.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxSwift

internal class UserRepository: IUserRepository {
    
    internal func getUserList() -> Observable<JSON?> {
        return Observable.create { observer in
            if let url = URL(string: CartrackConstants.GET_USERS) {
                Alamofire.request(url).responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let jsonData = response.result.value else {
                            observer.onError(CustomError.emptyDataSet)
                            return
                        }

                        let swiftyJsonVar = JSON(jsonData)
                        observer.onNext(swiftyJsonVar)
                        observer.onCompleted()

                    case let .failure(error):
                        observer.onError(error)
                    }
                }
            }
           
            return Disposables.create {}
        }
    }
}
