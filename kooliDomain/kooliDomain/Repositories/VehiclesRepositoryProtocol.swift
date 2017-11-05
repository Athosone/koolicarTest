//
//  VehiclesRepositoryProtocol.swift
//  kooliDomain
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import RxSwift

public protocol VehiclesRepositoryProtocol {
    func queryVehicles(filter: ((Vehicle) -> Bool)?) -> Observable<[Vehicle]>
}
