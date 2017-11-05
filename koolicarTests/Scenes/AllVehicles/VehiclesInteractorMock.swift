//
//  VehiclesInteractorMock.swift
//  koolicarTests
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import kooliDomain
import RxSwift

class VehiclesInteractorMock: VehiclesInteractorProtocol {

    var queryVehiclesCall = false
    var vehicle: Observable<[Vehicle]> = Observable.just([])
    func queryVehicles(fromCache: Bool, filter: ((Vehicle) -> Bool)?) -> Observable<[Vehicle]> {
        queryVehiclesCall = true
        return vehicle
    }
}
