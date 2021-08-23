//
//  ApiForecastGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct ApiForecastGateway: ForecastGateway {

    let service: ApiService

    func fetchForecast(latitude: Double, longitude: Double,
                       completion: @escaping FetchForecastHandler) {

        let request = ForecastCoordinateRequest(latitude: latitude, longitude: longitude)
        startFetchForecastRequest(request: request, completion: completion)
    }

    func fetchForecast(cityName: String,
                       completion: @escaping FetchForecastHandler) {

        let request = ForecastCityNameRequest(cityName: cityName)
        startFetchForecastRequest(request: request, completion: completion)
    }

    private func startFetchForecastRequest(request: ApiServiceRequest,
                                           completion: @escaping FetchForecastHandler) {

        service.startRequest(request: request) { (result: Result<ApiServiceResponse<ForecastResponse>, Error>) in
            switch result {
            case .success(let response):
                let lock = NSLock()
                var entites = [ForecastEntity]()
                let count = response.entity.list.count
                for (index, forecast) in response.entity.list.enumerated() {
                    { i, f in
                        fetchIcon(iconName: f.weather[0].icon) { (result) in
                            switch result {
                            case .success(let data):

                                let entity = ForecastEntity (
                                    temperature: f.main.temp,
                                    description: f.weather[0].main,
                                    date: f.dt_txt,
                                    icon: data
                                )

                                lock.lock()
                                entites.append(entity)
                                let currentCount = entites.count
                                lock.unlock()

                                if currentCount == count {
                                    completion(.success(entites))
                                }

                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    }(index, forecast)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchIcon(iconName: String,
                   completion: @escaping FetchForecastIconHandler) {

        let request = ForecastIconRequest(iconName: iconName)
        service.startRawDataRequest(request: request) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
