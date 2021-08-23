//
//  ApiServiceRequest.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

protocol ApiServiceRequest {
    var urlRequest: URLRequest? { get }
}
