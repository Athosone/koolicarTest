//
//  VehiclesRepositoryProvider.swift
//  kooliInMemPlatform
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import kooliDomain

public class VehiclesRepositoryProvider {

    public static func makeVehiclesRepository() -> VehiclesRepositoryImpl {
        return VehiclesRepositoryImpl(localDataSource: FileLoader())
    }

}
