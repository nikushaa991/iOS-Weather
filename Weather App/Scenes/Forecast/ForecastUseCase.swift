//
//  ForecastUseCase.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import Foundation

/**
 1. fetch current city
 2. if current city is nil fetch forecast using current location, else use fetched city for fetching forecast
 */

protocol ForecastUseCase {

    // handler
    typealias FetchForecastHandler = (Result<[ForecastEntity], Error>) -> Void

    // function
    func fetchForecast(completion: @escaping FetchForecastHandler)
}

// MARK: Default Implementation

class DefaultForecastUseCase: ForecastUseCase {

    // gateways
    var currentCityGateway: CurrentCityGateway
    let forecastGateway: ForecastGateway

    // helper
    let locationManager: LocationManager

    init (
        currentCityGateway: CurrentCityGateway,
        forecastGateway: ForecastGateway,
        locationManager: LocationManager
    ) {
        self.currentCityGateway = currentCityGateway
        self.forecastGateway = forecastGateway
        self.locationManager = locationManager
    }

    func fetchForecast(completion: @escaping FetchForecastHandler) {
        // fetch current city
        currentCityGateway.fetch { [weak self] (result) in
            switch result {
            case .success(let city):
                if let city = city {
                    // use fetched city for fetching forecast
                    self?.forecastGateway.fetchForecast(cityName: city.cityName) { (result) in
                        switch result {
                        case .success(let entities):
                            completion(.success(entities))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    // if current city is nil
                    // fetch forecast using current location
                    self?.locationManager.location { (result) in
                        switch result {
                        case .success((let latitude, let longitude)):
                            self?.forecastGateway.fetchForecast(latitude: latitude, longitude: longitude) { (result) in
                                switch result {
                                case .success(let entities):
                                    completion(.success(entities))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
