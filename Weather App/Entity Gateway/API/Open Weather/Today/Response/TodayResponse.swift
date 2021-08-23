//
//  TodayResponse.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct TodayResponse: Decodable {
    let weather: [TodayResponseWeather]
    let main: TodayResponseMain
    let wind: TodayResponseWind
    let clouds: TodayResponseClouds
    let name: String
}

struct TodayResponseWeather: Decodable {
    let main: String
}

struct TodayResponseMain: Decodable {
    let temp: Double
    let pressure: Double
    let humidity: Double
}

struct TodayResponseWind: Decodable {
    let speed: Double
    let deg: Double
}

struct TodayResponseClouds: Decodable {
    let all: Double
}

// MARK: - Extension of TodayApiResponse to converting it to TodayEntity

extension TodayResponse {

    func toEntity() -> TodayEntity {
        .init(
            city: .init(cityName: name),
            temperature: main.temp,
            description: weather[0].main,
            cloudiness: clouds.all,
            humidity: main.humidity,
            windSpeed: wind.speed,
            windDirection: wind.deg
        )
    }
}
