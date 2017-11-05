//
//  AllVehiclesNavigator.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import SwinjectStoryboard

protocol AllVehiclesNavigatorProtocol: NavigatorProtocol {
    func toDetailVehicle(vehicleId: Int)
}

class AllVehiclesNavigator: AllVehiclesNavigatorProtocol {

    private weak var navigationController: UINavigationController?
    private let swinStoryboard: SwinjectStoryboard

    init(swinStoryboard: SwinjectStoryboard) {
        self.swinStoryboard = swinStoryboard
    }

    func updateNavigationController(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func toDetailVehicle(vehicleId: Int) {
        guard let vehicleDetails = self.swinStoryboard
            .instantiateViewController(withIdentifier: VehicleDetailsViewController.reuseID)
            as? VehicleDetailsViewController else {
            fatalError("VehiclesDetailsViewController not registered properly")
        }
        vehicleDetails.presenter.vehicleId = vehicleId
        self.navigationController?.pushViewController(vehicleDetails, animated: true)
    }

}
