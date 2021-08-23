//
//  LocalPersistenceCityGateway.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import Foundation

struct LocalPersistenceCityGateway: CityGateway {

    let service: PersistenceService

    func fetch(completion: @escaping FetchHandler) {
        service.context.fetchEntities(withType: DBCityEntity.self) { (result) in
            switch result {
            case .success(let cities):
                completion(.success(cities.map { $0.toCityEntity() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    mutating func add(city: CityEntity, completion: AddCityHandler?) {
        let dbCityEntity = DBCityEntity(context: service.context)
        dbCityEntity.name = city.cityName
        service.saveContext()
        completion?(.success(()))
    }

    mutating func delete(city: CityEntity, completion: DeleteCityHandler?) {

        service.context.fetchEntities(withType: DBCityEntity.self,
            predicate: NSPredicate (
                format: "name == %@",
                city.cityName
            )
        ) { (result) in

            switch result {
            case .success(let cities):
                for city in cities {
                    service.context.delete(city)
                }
                service.saveContext()
                completion?(.success(()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
