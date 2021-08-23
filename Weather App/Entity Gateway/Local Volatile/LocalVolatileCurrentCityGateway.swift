//
//  LocalVolatileCurrentCityGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import Foundation

class LocalVolatileCurrentCityGateway: CurrentCityGateway {

    static let shared: CurrentCityGateway = LocalVolatileCurrentCityGateway()

    private var currentCity: CityEntity?

    private init() { } // for singleton pattern

    func fetch(completion: @escaping FetchHandler) {
        completion(.success(currentCity))
    }

    func set(city: CityEntity, completion: SetHandler?) {
        currentCity = city
        completion?(.success(()))
    }
}
