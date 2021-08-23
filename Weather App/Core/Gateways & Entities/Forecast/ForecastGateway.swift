//
//  ForecastGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

protocol ForecastGateway {

    /**
     fetches forecast entity based on parameters
     */

    // handler
    typealias FetchForecastHandler = (Result<[ForecastEntity], Error>) -> Void

    // functions
    func fetchForecast(latitude: Double, longitude: Double,
                       completion: @escaping FetchForecastHandler)

    func fetchForecast(cityName: String,
                       completion: @escaping FetchForecastHandler)

    /**
     fetches forecast icon based on icon name
     */

    // handler
    typealias FetchForecastIconHandler = (Result<Data, Error>) -> Void

    // function
    func fetchIcon(iconName: String,
                   completion: @escaping FetchForecastIconHandler)
}
