//
//  ForecastCityNameRequest.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct ForecastCityNameRequest: OpenWeatherApiServiceRequest {

    let cityName: String

    var urlRequest: URLRequest? {
        let urlString = initialUrlBuilder(uri: "forecast").appending("&q=\(cityName)")
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
