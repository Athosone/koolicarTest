//
//  VehiclesRepository.swift
//  kooliInMemPlatform
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import RxSwift
import kooliDomain

public class VehiclesRepositoryImpl: VehiclesRepositoryProtocol {

    private let dataSource: DataSourceProtocol

    // For the test purpose
    // it could be a network source or whatever
    init(localDataSource: DataSourceProtocol) {
        self.dataSource = localDataSource
    }

    public func queryVehicles(filter: ((Vehicle) -> Bool)?) -> Observable<[Vehicle]> {
        if let filter = filter {
            return self.dataSource.fetchData().map({ (vehicles) -> [Vehicle] in
                return vehicles.filter(filter)
            })
        }
        return self.dataSource.fetchData()
    }

}
