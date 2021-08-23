//
//  CityGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/31/21.
//

import Foundation

protocol CityGateway {

    /**
     returns all saved cities
     */

    // handler
    typealias FetchHandler = (Result<[CityEntity], Error>) -> Void

    // function
    func fetch(completion: @escaping FetchHandler)

    /**
     saves city
     */

    // handler
    typealias AddCityHandler = (Result<Void, Error>) -> Void

    // function
    mutating func add(city: CityEntity, completion: AddCityHandler?)

    
    /**
     deletes city
     */

    // handler
    typealias DeleteCityHandler = (Result<Void, Error>) -> Void

    // function
    mutating func delete(city: CityEntity, completion: DeleteCityHandler?)
}
