//
//  TodayInteractor.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import Foundation

protocol TodayInteractor {

    /**
     determine current coordinates
     fetch today (coordinates) - also save current location city
     fetch saved cities
     for each saved city - fetch today (cityName)
     */

    // handler
    typealias FetchTodayHandler = (Result<TodayEntity, Error>) -> Void

    // function
    func fetchToday(completion: @escaping FetchTodayHandler)

    /**
     if current city is current location error
     else delete from saved cities
     */

    // handler
    typealias DeleteCityHandler = (Result<Void, Error>) -> Void

    // function
    mutating func delete(city: CityEntity, completion: DeleteCityHandler?)

    /**
     set current city
     */

    // handler
    typealias SetCurrentCityHandler = (Result<Void, Error>) -> Void

    // function
    mutating func set(currentCity: CityEntity, completion: SetCurrentCityHandler?)
}

// MARK: - Default Implementation

class DefaultTodayInteractor: TodayInteractor {

    // current location city entity
    // used for deletion handling
    private var currentLocationCity: CityEntity? = nil

    // gateways
    let todayGateway: TodayGateway
    var cityGateway: CityGateway
    var currentCityGateway: CurrentCityGateway

    // helper
    let locationManager: LocationManager

    init (
        todayGateway: TodayGateway,
        cityGateway: CityGateway,
        currentCityGateway: CurrentCityGateway,
        locationManager: LocationManager
    ) {
        self.todayGateway = todayGateway
        self.cityGateway = cityGateway
        self.currentCityGateway = currentCityGateway
        self.locationManager = locationManager
    }

    func fetchToday(completion: @escaping FetchTodayHandler) {

        // determine current coordinates
        locationManager.location { [weak self] (result) in
            switch result {
            case .success((let latitude, let longitude)):

                // fetch today (coordinates)
                self?.todayGateway.fetchToday(latitude: latitude, longitude: longitude) { [weak self] (result) in
                    switch result {
                    case .success(let today):
                        // also save current location city
                        self?.currentLocationCity = today.city
                        completion(.success(today))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }

                // fetch saved cities
                self?.cityGateway.fetch { [weak self] (result) in
                    switch result {
                    case .success(let cities):
                        // for each saved city
                        for city in cities {
                            // fetch today (cityName)
                            self?.todayGateway.fetchToday(cityName: city.cityName) { (result) in
                                switch result {
                                case .success(let today):
                                    completion(.success(today))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func delete(city: CityEntity, completion: DeleteCityHandler?) {
        // if current city is current location
        if city == currentLocationCity {
            // error
            completion?(.failure(CoreError(message: "You can not delete current location city")))
        } else { // else
            // delete from saved cities
            cityGateway.delete(city: city, completion: completion)
        }
    }

    func set(currentCity: CityEntity, completion: SetCurrentCityHandler?) {
        // set current city
        currentCityGateway.set(city: currentCity, completion: completion)
    }
}
