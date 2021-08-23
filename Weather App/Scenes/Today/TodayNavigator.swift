//
//  TodayNavigator.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import UIKit

protocol TodayNavigator {
    func navigate2AddCity(containingCities: [CityEntity], delegate: AddCityDelegate?)
}

struct DefaultTodayNavigator: TodayNavigator {

    weak var viewController: TodayViewController?

    func navigate2AddCity(containingCities: [CityEntity], delegate: AddCityDelegate?) {
        let factory: AddCityFactory = DefaultAddCityFactory()
        let vc = factory.make(containingCities: containingCities, delegate: delegate)
        vc.modalPresentationStyle = .overFullScreen
        viewController?.present(vc, animated: true, completion: nil)
    }
}
