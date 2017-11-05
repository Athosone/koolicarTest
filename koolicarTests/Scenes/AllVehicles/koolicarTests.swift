//
//  koolicarTests.swift
//  koolicarTests
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import XCTest
import kooliDomain
import RxSwift
import RxCocoa
import RxBlocking
import Nimble

@testable import koolicar

class KoolicarTests: XCTestCase {
    private let disposeBag = DisposeBag()

    var vehicleInteractor: VehiclesInteractorMock!
    var allVehicleNavigator: AllVehiclesNavigatorMock!
    var presenter: AllVehiclesPresenter!

    override func setUp() {
        super.setUp()
        vehicleInteractor = VehiclesInteractorMock()
        allVehicleNavigator = AllVehiclesNavigatorMock()
        presenter = AllVehiclesPresenter(navigator: allVehicleNavigator, vehiclesInteractor: vehicleInteractor)
    }

    func testTransformTriggerInvoked() {
        let trigger = PublishSubject<Void>()
        let input = createInput(trigger: trigger)

        let output = presenter.transform(input: input)

        output.vehicles.drive().disposed(by: self.disposeBag)
        trigger.onNext(())
        expect(self.vehicleInteractor.queryVehiclesCall).to(equal(true))
    }

    func testTransformToItem() {
        let trigger = PublishSubject<Void>()
        let input = createInput(trigger: trigger)
        let output = presenter.transform(input: input)

        vehicleInteractor.vehicle = Observable.just(createVehicles())
        output.vehicles.drive().disposed(by: self.disposeBag)
        trigger.onNext(())

        let vehicles = try! output.vehicles.toBlocking().first()! // swiftlint:disable:this force_try
        expect(vehicles.count).to(equal(3))
    }

    func testTransformSelection() {
        let trigger = PublishSubject<Void>()
        let selection = PublishSubject<IndexPath>()
        let input = createInput(selection: selection, trigger: trigger)
        let output = presenter.transform(input: input)

        vehicleInteractor.vehicle = Observable.just(createVehicles())
        output.vehicles.drive().disposed(by: self.disposeBag)
        output.selectedVehicle.drive().disposed(by: self.disposeBag)

        trigger.onNext(())
        selection.onNext(IndexPath(item: 0, section: 0))

        expect(self.allVehicleNavigator.toDetailVehicleCalled).to(equal(true))
        expect(self.allVehicleNavigator.vehicleIdPassed).to(equal(70076))

    }

    override func tearDown() {
        super.tearDown()
    }

    private func createInput(selection: Observable<IndexPath> = Observable.never(),
                             trigger: Observable<Void>) -> AllVehiclesPresenter.Input {
        return AllVehiclesPresenter.Input(selection: selection.asDriverOnErrorJustComplete(),
                                          trigger: trigger.asDriverOnErrorJustComplete())
    }

    private func createVehicles() -> [Vehicle] {
        let vehiclesDecoded = try! JSONDecoder().decode([String: [Vehicle]].self, // swiftlint:disable:this force_try
                                                        from: self.vehiclesData)
        return vehiclesDecoded["vehicles"]!
    }

    private let vehiclesData: Data = """
{
 "vehicles": [
        {
            "address_id": 70076,
            "id": 10749,
            "year": 2012,
            "doors_count": 5,
            "places_count": 5,
            "fuel_type_cd": 0,
            "gears_type_cd": 1,
            "vehicle_model": "Micra",
            "brand": "Nissan",
            "category": "CITADINE",
            "thumbnail_url": "https://koolicar.s3.amazonaws.com/uploads/photo/6103/thumb_2015-11-09_16.13.02.jpg",
            "distance_string": "Paris 11'e8me",
            "fake_latitude": 48.8619248152841,
            "fake_longitude": 2.38026285387939
        },
        {
            "address_id": 16078,
            "id": 3736,
            "year": 2008,
            "doors_count": 5,
            "places_count": 7,
            "fuel_type_cd": 1,
            "gears_type_cd": 0,
            "vehicle_model": "C4 Picasso",
            "brand": "Citroen",
            "category": "FAMILIALE",
            "thumbnail_url": "https://koolicar.s3.amazonaws.com/uploads/photo/2106/thumb_Hadad-pic.jpg",
            "distance_string": "Paris 11'e8me",
            "fake_latitude": 48.8676012152841,
            "fake_longitude": 2.383478008763
        },
        {
            "address_id": 120930,
            "id": 9730,
            "year": 2013,
            "doors_count": 5,
            "places_count": 5,
            "fuel_type_cd": 1,
            "gears_type_cd": 1,
            "vehicle_model": "C3 Picasso",
            "brand": "Citroen",
            "category": "FAMILIALE",
            "thumbnail_url": "https://koolicar.s3.amazonaws.com/uploads/photo/10337/thumb_C3.jpg",
            "distance_string": "Paris 13'e8me",
            "fake_latitude": 48.8277282152841,
            "fake_longitude": 2.36240612183264
        }
    ]
}
""".data(using: .utf8)!

}
