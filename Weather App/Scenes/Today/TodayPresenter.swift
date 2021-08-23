//
//  TodayPresenter.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/2/21.
//

import Foundation

protocol TodayPresenter {
    func viewDidLoad()
    func refreshTapped()
    func numberOfItems() -> Int
    func viewModelForItem(at index: Int) -> TodayViewModel
    func itemPressed(at index: Int)
    func itemScrolled(to index: Int)
    func plusTapped()
}

class DefaultTodayPresenter: TodayPresenter {

    var interactor: TodayInteractor
    let navigator: TodayNavigator
    weak var view: TodayView?

    init (
        interactor: TodayInteractor,
        navigator: TodayNavigator,
        view: TodayView? = nil
    ) {
        self.interactor = interactor
        self.navigator = navigator
        self.view = view
    }

    var todays: [TodayEntity] = [] {
        didSet { view?.reloadData() }
    }

    func viewDidLoad() {
        load()
    }

    func refreshTapped() {
        todays = []
        load()
    }

    func numberOfItems() -> Int {
        todays.count
    }

    func viewModelForItem(at index: Int) -> TodayViewModel {
        TodayViewModel(index: index, entity: entityForItem(at: index))
    }

    func itemPressed(at index: Int) {
        let city = entityForItem(at: index).city
        interactor.delete(city: city) { [weak self] (result) in
            switch result {
            case .success:
                self?.todays.remove(at: index)
            case .failure(let error):
                self?.show(error: error.localizedDescription)
            }
        }
    }

    func itemScrolled(to index: Int) {
        let city = entityForItem(at: index).city
        interactor.set(currentCity: city) { [weak self] (result) in
            switch result {
            case .success: {}()
            case .failure(let error):
                self?.show(error: error.localizedDescription)
            }
        }
    }

    func plusTapped() {
        let containingCities = todays.map { $0.city }
        let delegate = self
        navigator.navigate2AddCity(containingCities: containingCities, delegate: delegate)
    }
}

// MARK: extention AddCityDelegate
extension DefaultTodayPresenter: AddCityDelegate {

    func handle(today: TodayEntity) {
        todays.append(today)
    }
}

// MARK: extention helpers
extension DefaultTodayPresenter {

    private func load() {
        show(.spinner)
        var respond = false
        interactor.fetchToday { [weak self] (result) in
            switch result {
            case .success(let today):
                self?.todays.append(today)
                if !respond {
                    respond = true
                    self?.show(.content)
                }
            case .failure(let error):
                self?.show(error: error.localizedDescription)
            }
        }
    }

    private func show(error: String) {
        show(.error)
        view?.show(error: error)
    }

    private enum Subviews: Int {
        case content
        case spinner
        case error
    }

    private func show(_ subview: Subviews) {
        let visibilities: [Bool]
        switch subview {
        case .content: visibilities = [false, true, true]
        case .spinner: visibilities = [true, false, true]
        case .error:   visibilities = [true, true, false]
        }
        view?.contentVisibility(isHiden: visibilities[0])
        view?.spinnerVisibility(isHiden: visibilities[1])
        view?.errorVisibility(isHiden: visibilities[2])
    }

    private func entityForItem(at index: Int) -> TodayEntity { todays[index] }

    private func containsCity(named city: String) -> Bool {
        todays.contains { $0.city.cityName.lowercased() == city.lowercased() }
    }
}
