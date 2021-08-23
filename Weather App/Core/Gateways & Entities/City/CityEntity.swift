//
//  CityEntity.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import Foundation

struct CityEntity {
    let cityName: String
}

extension CityEntity: Equatable {
    static func ==(lhs: CityEntity, rhs: CityEntity) -> Bool {
        return lhs.cityName == rhs.cityName
    }
}
