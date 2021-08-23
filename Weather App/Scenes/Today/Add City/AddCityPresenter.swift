//
//  AddCityPresenter.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import Foundation

protocol AddCityPresenter {
    func plusTapped(input: String)
}

class DefaultAddCityPresenter: AddCityPresenter {

    var useCase: AddCityUseCase
    weak var view: AddCityView?
    weak var delegate: AddCityDelegate?

    init (
        useCase: AddCityUseCase,
        view: AddCityView? = nil,
        delegate: AddCityDelegate? = nil
    ) {
        self.useCase = useCase
        self.view = view
        self.delegate = delegate
    }

    func plusTapped(input: String) {
        useCase.add(city: .init(cityName: input)) { [weak self] (result) in
            switch result {
            case .success(let today):
                self?.delegate?.handle(today: today)
                self?.view?.dismiss()
            case .failure /* (let error) */ :
                self?.view?.show(error: "City with that name was not found!")
            }
        }
    }
}
