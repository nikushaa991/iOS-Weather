//
//  TodayCityNameRequest.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/31/21.
//

import Foundation

struct TodayCityNameRequest: OpenWeatherApiServiceRequest {

    let cityName: String

    var urlRequest: URLRequest? {
        let urlString = initialUrlBuilder(uri: "weather").appending("&q=\(cityName)")
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
