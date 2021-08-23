//
//  DBCityEntity+CoreDataProperties.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/26/21.
//
//

import Foundation
import CoreData


extension DBCityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBCityEntity> {
        return NSFetchRequest<DBCityEntity>(entityName: "DBCityEntity")
    }

    @NSManaged public var name: String

}

extension DBCityEntity : Identifiable {

}

// MARK: - Extension of DBCityEntity to create CityEntity

extension DBCityEntity {
    func toCityEntity() -> CityEntity { .init(cityName: name) }
}
