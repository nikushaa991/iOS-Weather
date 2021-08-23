//
//  ForecastResponse.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct ForecastResponse: Decodable {
    let list: [ForecastResponseList]
}

struct ForecastResponseList: Decodable {
    let main: ForecastResponseListMain
    let weather: [ForecastResponseListWeather]
    let dt_txt: String
}

struct ForecastResponseListMain: Decodable {
    let temp: Double
}

struct ForecastResponseListWeather: Decodable {
    let main: String
    let icon: String
}
