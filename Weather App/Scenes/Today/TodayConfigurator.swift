//
//  TodayConfigurator.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/2/21.
//

import Foundation

struct TodayConfigurator {

    func configure(_ viewController: TodayViewController) {

        let todayGateway: TodayGateway = ApiTodayGateway(service: DefaultApiService.defaultShared)
        let cityGateway: CityGateway = LocalPersistenceCityGateway(service: DefaultPersistenceService.shared)
        let currentCityGateway: CurrentCityGateway = LocalVolatileCurrentCityGateway.shared

        let locationManager: LocationManager = DefaultLocationManager()

        let interactor: TodayInteractor = DefaultTodayInteractor (
            todayGateway: todayGateway,
            cityGateway: cityGateway,
            currentCityGateway: currentCityGateway,
            locationManager: locationManager
        )

        let navigator: TodayNavigator = DefaultTodayNavigator(viewController: viewController)

        let presenter: TodayPresenter = DefaultTodayPresenter (
            interactor: interactor,
            navigator: navigator,
            view: viewController
        )

        viewController.presenter = presenter
    }
}
