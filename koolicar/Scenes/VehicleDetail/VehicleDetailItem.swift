//
//  VehicleDetailItem.swift
//  koolicar
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import MapKit
import kooliDomain

struct VehicleDetailItem {
    let category: String
    let brand: String
    let year: String
    let vehicleImage: URL
    let coordinate: CLLocationCoordinate2D
    let fuel: String
    let places: String
    let doors: String
    let gears: String

    static func from(vehicle: Vehicle) -> VehicleDetailItem {
        let fuel: String = vehicle.fuelType > 0 ? "⛽️ Essence" : "⛽️ Diesel"
        let places: String = "🤗 \(vehicle.placesCount) places"
        let doors: String = "🚪 \(vehicle.doorsCount) portes"
        let gears: String = vehicle.gearsType > 0 ? "🚗 Automatique" : "🚗 Manuelle"
        let coordinate = CLLocationCoordinate2D(latitude: vehicle.latitude, longitude: vehicle.longitude)
        let thumbNailUrl = vehicle.thumbnailUrl
        // Should be optimized using enum with different image size (small, medium...)
        let mediumImageString = thumbNailUrl.absoluteString
            .replacingOccurrences(of: "thumb", with: "medium")
        let mediumImage: URL? = URL(string: mediumImageString)

        return VehicleDetailItem(category: vehicle.category,
                                 brand: vehicle.brand,
                                 year: String(describing: vehicle.year),
                                 vehicleImage: mediumImage ?? thumbNailUrl,
                                 coordinate: coordinate,
                                 fuel: fuel,
                                 places: places,
                                 doors: doors,
                                 gears: gears)
    }
}
