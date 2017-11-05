//
//  VehicleDetailsAssembly.swift
//  koolicar
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

import kooliDomain
import kooliInMemPlatform

class VehicleDetailsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(VehicleDetailsPresenter.self) { (r) -> VehicleDetailsPresenter in
            return VehicleDetailsPresenter(vehiclesInteractor: r.resolve(VehiclesInteractorProtocol.self)!)
        }
        container.storyboardInitCompleted(VehicleDetailsViewController.self) { (r, c: VehicleDetailsViewController) in
            c.presenter = r.resolve(VehicleDetailsPresenter.self)
        }

    }
}
