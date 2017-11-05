//
//  AllVehiclesPresenter.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import kooliDomain
import RxSwift
import RxCocoa

class AllVehiclesPresenter {

    private let navigator: AllVehiclesNavigatorProtocol
    private let vehiclesInteractor: VehiclesInteractorProtocol

    init(navigator: AllVehiclesNavigatorProtocol, vehiclesInteractor: VehiclesInteractorProtocol) {
        self.navigator = navigator
        self.vehiclesInteractor = vehiclesInteractor
    }

    func updateNavigator(navigationController: UINavigationController?) {
        self.navigator.updateNavigationController(navigationController: navigationController)
    }

}

extension AllVehiclesPresenter: PresenterType {
    struct Input {
        let selection: Driver<IndexPath>
        let trigger: Driver<Void>
    }

    struct Output {
        let vehicles: Driver<[VehicleItem]>
        let selectedVehicle: Driver<VehicleItem>
    }

    func transform(input: AllVehiclesPresenter.Input) -> AllVehiclesPresenter.Output {
        let vehicles = input.trigger.flatMapLatest { _ in
            return self.vehiclesInteractor.queryVehicles(fromCache: true, filter: nil)
                .map({ (vehicles) -> [VehicleItem] in
                    return vehicles.map { VehicleItem.from(vehicle: $0) }
                }).asDriverOnErrorJustComplete()
        }
        let selectedVehicle = input.selection
            .withLatestFrom(vehicles.asDriver()) { (indexPath, vehicles: [VehicleItem]) -> VehicleItem in
            return vehicles[indexPath.row]
            }.do(onNext: { v in
                self.navigator.toDetailVehicle(vehicleId: v.vehicleId)
            })
        let output = Output(vehicles: vehicles, selectedVehicle: selectedVehicle)

        return output
    }
}
