//
//  ServicesAssembly.swift
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

class ServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(VehiclesRepositoryProtocol.self) { (_) -> VehiclesRepositoryImpl in
            return VehiclesRepositoryProvider.makeVehiclesRepository()
        }

        container.register(VehiclesInteractorProtocol.self) { (r) -> VehiclesInteractor in
            let cacheRepository: VehiclesRepositoryProtocol = r.resolve(VehiclesRepositoryProtocol.self)!
            return VehiclesInteractor(cacheRepository: cacheRepository)
        }
    }
}
