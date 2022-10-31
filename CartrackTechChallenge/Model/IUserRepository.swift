//
//  IUserRepository.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

internal protocol IUserRepository {
    func getUserList() -> Observable<JSON?>
}
