//
//  kooliInMemPlatformTests.swift
//  kooliInMemPlatformTests
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import Nimble

@testable import kooliInMemPlatform

class KooliInMemPlatformTests: XCTestCase {

    var vehicleRepo: VehiclesRepositoryImpl!

    override func setUp() {
        super.setUp()
        vehicleRepo = VehiclesRepositoryImpl(localDataSource:
            FileLoader(bundle: Bundle(for: KooliInMemPlatformTests.self)))
    }

    override func tearDown() {
        super.tearDown()
    }

    func testQueryVehicles() {
        let vehicles: Int = try! vehicleRepo.queryVehicles(filter: nil) // swiftlint:disable:this force_try
            .toBlocking()
            .first()!.count

        expect(vehicles).toNot(equal(0))

    }

    func testQueryVehiclesWithId() {
        let vehicles: Int = try! vehicleRepo.queryVehicles { v in // swiftlint:disable:this force_try
            return v.addressId == 59776
            }.toBlocking().first()!.count
        expect(vehicles).to(equal(1))

    }

}
