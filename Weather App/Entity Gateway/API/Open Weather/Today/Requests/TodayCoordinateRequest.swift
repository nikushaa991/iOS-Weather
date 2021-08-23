//
//  TodayCoordinateRequest.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct TodayCoordinateRequest: OpenWeatherApiServiceRequest {

    let latitude: Double
    let longitude: Double

    var urlRequest: URLRequest? {
        let urlString = initialUrlBuilder(uri: "weather").appending("&lat=\(latitude)&lon=\(longitude)")
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
