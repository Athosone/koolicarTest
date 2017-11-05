//
//  VehicleItem.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import kooliDomain

struct VehicleItem {
    let vehicleId: Int
    let brand: String
    let category: String
    let vehicleImage: URL
    let infosLabel: String
    let descLabel: String

    static func from(vehicle: Vehicle) -> VehicleItem {
        let infos = "\(String(describing: vehicle.year)) . \(vehicle.distanceStr ?? "")"
        let fuel = vehicle.fuelType > 0 ? "⛽️ Essence" : "⛽️ Diesel"
        let places = "🤗 \(String(describing: vehicle.placesCount)) places"
        let gears = vehicle.gearsType == 0 ? "🚗 Automatique" : "🚗 Manuelle"
        let desc = [fuel, places, gears].joined(separator: " . ")
        return VehicleItem(vehicleId: vehicle.addressId,
                           brand: vehicle.brand,
                           category: vehicle.category.capitalized,
                           vehicleImage: vehicle.thumbnailUrl,
                           infosLabel: infos, descLabel: desc)
    }
}
