//
//  VehicleDetailsPresenter.swift
//  koolicar
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

import kooliDomain

class VehicleDetailsPresenter {
    private let vehiclesInteractor: VehiclesInteractorProtocol
    var vehicleId: Int = 0

    init(vehiclesInteractor: VehiclesInteractorProtocol) {
        self.vehiclesInteractor = vehiclesInteractor
    }
}

extension VehicleDetailsPresenter: PresenterType {

    struct Input {
        let trigger: Driver<Void>
    }

    struct Output {
        let vehicleDetailItem: Driver<VehicleDetailItem>
    }

    func transform(input: Input) -> Output {
        let addressId = self.vehicleId
        let vehicleDetail = input.trigger.flatMapLatest { _ in
            return self.vehiclesInteractor.queryVehicles(fromCache: true) { (v) in
                return v.addressId == addressId
                }.map({ (results) -> VehicleDetailItem? in
                    if let vehicle = results.first {
                        return VehicleDetailItem.from(vehicle: vehicle)
                    }
                    return nil
                }).unwrap().asDriverOnErrorJustComplete()
        }

        return Output(vehicleDetailItem: vehicleDetail)
    }
}
