//
//  ApiTodayGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct ApiTodayGateway: TodayGateway {

    let service: ApiService

    func fetchToday(latitude: Double, longitude: Double,
                    completion: @escaping FetchTodayHandler) {

        let request = TodayCoordinateRequest(latitude: latitude, longitude: longitude)
        startFetchTodayRequest(request: request, completion: completion)
    }

    func fetchToday(cityName: String,
                    completion: @escaping FetchTodayHandler) {

        let request = TodayCityNameRequest(cityName: cityName)
        startFetchTodayRequest(request: request, completion: completion)
    }

    private func startFetchTodayRequest(request: ApiServiceRequest,
                                        completion: @escaping FetchTodayHandler) {

        service.startRequest(request: request) { (result: Result<ApiServiceResponse<TodayResponse>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity.toEntity()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
