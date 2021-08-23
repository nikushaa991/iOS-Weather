//
//  ForecastIconRequest.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import Foundation

struct ForecastIconRequest: OpenWeatherApiServiceRequest {

    let iconName: String

    var urlRequest: URLRequest? {
        let urlString = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
