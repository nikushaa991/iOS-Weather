//
//  AddCityFactory.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import Foundation

protocol AddCityFactory {
    func make(containingCities: [CityEntity], delegate: AddCityDelegate?) -> AddCityViewController
}

struct DefaultAddCityFactory: AddCityFactory {

    func make(containingCities: [CityEntity] = [], delegate: AddCityDelegate? = nil) -> AddCityViewController {
        let view = AddCityViewController()
        let configurator = AddCityConfigurator()
        configurator.configure(view, containingCities, delegate)
        return view
    }
}
