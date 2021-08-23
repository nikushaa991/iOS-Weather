//
//  AddCityUseCase.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import Foundation

protocol AddCityUseCase {
    /**
     if city is already added
     return error with appropriate description
     else
     fetch today (cityName)
     if returned success
     add new saved city and return fetched today entity
     else error
     */

    // handler
    typealias AddCityHandler = (Result<TodayEntity, Error>) -> Void

    // function
    mutating func add(city: CityEntity, completion: AddCityHandler?)
}

// MARK: - Default Implementation

class DefaultAddCityUseCase: AddCityUseCase {

    let todayGateway: TodayGateway
    var cityGateway: CityGateway
    var containing: [CityEntity]

    init (
        todayGateway: TodayGateway,
        cityGateway: CityGateway,
        containing: [CityEntity]
    ) {
        self.todayGateway = todayGateway
        self.cityGateway = cityGateway
        self.containing = containing
    }

    func add(city: CityEntity, completion: AddCityHandler? = nil) {
        // if city is already added
        if containing.contains(city) {
            // return error with appropriate description
            completion?(.failure(CoreError(message: "City is already added")))
            return
        }
        // fetch today (cityName)
        todayGateway.fetchToday(cityName: city.cityName) { [weak self] (result) in
            switch result {
            // if returned success
            case .success(let today):
                // add new saved city
                self?.cityGateway.add(city: city, completion: { [weak self] (result) in
                    switch result {
                    case .success:
                        // add new saved city (locally)
                        self?.containing.append(city)
                        // and return fetched today entity
                        completion?(.success(today))
                    case .failure(let error):
                        completion?(.failure(error))
                    }
                })
            // else error
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
