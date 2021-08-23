//
//  TodayGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

protocol TodayGateway {

    /**
     fetches today entity based on parameters
     */

    // handler
    typealias FetchTodayHandler = (Result<TodayEntity, Error>) -> Void

    // functions
    func fetchToday(latitude: Double, longitude: Double,
                    completion: @escaping FetchTodayHandler)

    func fetchToday(cityName: String,
                    completion: @escaping FetchTodayHandler)
}
