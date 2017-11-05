//
//  Configurator.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class Configurator {

    private let assembler = Assembler([ServicesAssembly(),
                                       AllVehiclesAssembly(),
                                       VehicleDetailsAssembly()], container: SwinjectStoryboard.defaultContainer)

    func rootViewController() -> AllVehiclesViewController? {
        return SwinjectStoryboard.create(name: "AllVehicles", bundle: nil)
            .instantiateViewController(withIdentifier: AllVehiclesViewController.reuseID) as? AllVehiclesViewController
    }

}
