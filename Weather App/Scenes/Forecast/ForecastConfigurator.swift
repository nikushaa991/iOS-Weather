//
//  ForecastConfigurator.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/8/21.
//

import Foundation

struct ForecastConfigurator {

    func confugure(_ viewController: ForecastViewController) {

        let currentCityGateway: CurrentCityGateway = LocalVolatileCurrentCityGateway.shared
        let forecastGateway: ForecastGateway = ApiForecastGateway(service: DefaultApiService.defaultShared)
        let locationManager: LocationManager = DefaultLocationManager()

        let useCase: ForecastUseCase = DefaultForecastUseCase (
            currentCityGateway: currentCityGateway,
            forecastGateway: forecastGateway,
            locationManager: locationManager
        )

        let presenter: ForecastPresenter = DefaultForecastPresenter (
            useCase: useCase,
            view: viewController
        )

        viewController.presenter = presenter
    }
}
