//
//  AllVehiclesAssembly.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

import kooliDomain
import kooliInMemPlatform

class AllVehiclesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AllVehiclesNavigatorProtocol.self) { (_) -> AllVehiclesNavigator in
            return AllVehiclesNavigator(swinStoryboard: SwinjectStoryboard.create(name: "VehicleDetails", bundle: nil))
        }

        container.register(AllVehiclesPresenter.self) { (r) -> AllVehiclesPresenter in
            return AllVehiclesPresenter(navigator: r.resolve(AllVehiclesNavigatorProtocol.self)!,
                                        vehiclesInteractor: r.resolve(VehiclesInteractorProtocol.self)!)
        }

        container.storyboardInitCompleted(AllVehiclesViewController.self) { (r, c: AllVehiclesViewController) in
            c.presenter = r.resolve(AllVehiclesPresenter.self)
        }
    }
}
