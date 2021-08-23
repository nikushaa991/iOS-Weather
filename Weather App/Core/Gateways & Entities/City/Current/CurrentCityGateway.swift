//
//  CurrentCityGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/31/21.
//

import Foundation

protocol CurrentCityGateway {

    /**
     returns Current City if it was set
     else nil
     */

    // handler
    typealias FetchHandler = (Result<CityEntity?, Error>) -> Void

    // function
    func fetch(completion: @escaping FetchHandler)

    /**
     
     */

    // handler
    typealias SetHandler = (Result<Void, Error>) -> Void

    // function
    mutating func set(city: CityEntity, completion: SetHandler?)
}
