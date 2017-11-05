//
//  Car.swift
//  kooliDomain
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation

public struct Vehicle: Codable {
    public let addressId: Int
    public let id: Int
    public let year: Int
    public let doorsCount: Int
    public let placesCount: Int
    public let fuelType: Int
    public let gearsType: Int
    public let model: String
    public let brand: String
    public let category: String
    public let thumbnailUrl: URL
    public let distanceStr: String?
    public let latitude: Double
    public let longitude: Double

    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case id
        case year
        case doorsCount = "doors_count"
        case placesCount = "places_count"
        case fuelType = "fuel_type_cd"
        case gearsType = "gears_type_cd"
        case model = "vehicle_model"
        case brand
        case category
        case thumbnailUrl = "thumbnail_url"
        case distanceStr = "distance_string"
        case latitude = "fake_latitude"
        case longitude = "fake_longitude"
    }
}
