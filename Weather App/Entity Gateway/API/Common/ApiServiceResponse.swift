//
//  ApiServiceResponse.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct ApiServiceResponse<T: Decodable> {
    let entity: T
}
