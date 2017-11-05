//
//  CarsInteractor.swift
//  kooliDomain
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import RxSwift

public protocol VehiclesInteractorProtocol {
    func queryVehicles(fromCache: Bool, filter: ((Vehicle) -> Bool)?) -> Observable<[Vehicle]>
}

public class VehiclesInteractor: VehiclesInteractorProtocol {

    private let cacheRepository: VehiclesRepositoryProtocol
  //  private let networkRepository: VehiclesRepositoryProtocol

    public init(cacheRepository: VehiclesRepositoryProtocol) {// networkRepository: VehiclesRepository) {
        self.cacheRepository = cacheRepository
//        self.networkRepository = networkRepository
    }

    public func queryVehicles(fromCache: Bool, filter: ((Vehicle) -> Bool)?) -> Observable<[Vehicle]> {
        if fromCache {
            return cacheRepository.queryVehicles(filter: filter)
        }
        // return networkRepository.query
        return Observable.just([])
    }
}
