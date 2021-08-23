//
//  AddCityConfigurator.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import Foundation

struct AddCityConfigurator {

    func configure(_ view: AddCityViewController, _ containingCities: [CityEntity], _ delegate: AddCityDelegate?) {

        let todayGateway: TodayGateway = ApiTodayGateway(service: DefaultApiService.defaultShared)
        let cityGateway: CityGateway = LocalPersistenceCityGateway(service: DefaultPersistenceService.shared)

        let useCase: AddCityUseCase = DefaultAddCityUseCase(
            todayGateway: todayGateway,
            cityGateway: cityGateway,
            containing: containingCities
        )

        let presenter: AddCityPresenter = DefaultAddCityPresenter(
            useCase: useCase,
            view: view,
            delegate: delegate
        )

        view.presenter = presenter
    }
}
