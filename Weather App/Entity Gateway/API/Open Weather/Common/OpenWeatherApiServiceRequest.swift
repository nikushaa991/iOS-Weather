//
//  OpenWeatherApiServiceRequest.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import Foundation

protocol OpenWeatherApiServiceRequest: ApiServiceRequest {

    var root: String { get }
    var key: String { get }
    var units: String { get }

    // assemles root, uri, key and units
    func initialUrlBuilder(uri: String) -> String
}

extension OpenWeatherApiServiceRequest {

    var root: String { "https://api.openweathermap.org/data/2.5" }
    var key: String { "e7e7d5d2da4aee3dcb44529c9c69f31a" }
    var units: String { "metric" }

    func initialUrlBuilder(uri: String) -> String {
        return "\(root)/\(uri)?appid=\(key)&units=\(units)"
    }
}
