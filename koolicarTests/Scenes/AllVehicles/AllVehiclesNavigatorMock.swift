//
//  AllVehiclesNavigatorMock.swift
//  koolicarTests
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import kooliDomain
@testable import koolicar

class AllVehiclesNavigatorMock: AllVehiclesNavigatorProtocol {

    var toDetailVehicleCalled = false
    var vehicleIdPassed = 0

    func updateNavigationController(navigationController: UINavigationController?) {

    }

    func toDetailVehicle(vehicleId: Int) {
        toDetailVehicleCalled = true
        vehicleIdPassed = vehicleId
    }

}
