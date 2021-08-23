//
//  ForecastPresenter.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/8/21.
//

import Foundation

protocol ForecastPresenter {
    func viewDidLoad()
    func refreshTapped()
    func sectionCount() -> Int
    func cellCount(in section: Int) -> Int
    func sectionModel(of section: Int) -> ForecastHeaderViewModel
    func cellModel(at indexPath: IndexPath) -> ForecastCellViewModel
}

class DefaultForecastPresenter: ForecastPresenter {

    let useCase: ForecastUseCase
    weak var view: ForecastView?

    var model: [(header: ForecastHeaderViewModel, cells: [ForecastCellViewModel])] = [] {
        didSet { view?.reloadData() }
    }

    init (
        useCase: ForecastUseCase,
        view: ForecastView? = nil
    ) {
        self.useCase = useCase
        self.view = view
    }

    func viewDidLoad() {
        load()
    }

    func refreshTapped() {
        load()
    }

    func sectionCount() -> Int {
        model.count
    }

    func cellCount(in section: Int) -> Int {
        model[section].cells.count
    }

    func sectionModel(of section: Int) -> ForecastHeaderViewModel {
        model[section].header
    }

    func cellModel(at indexPath: IndexPath) -> ForecastCellViewModel {
        model[indexPath.section].cells[indexPath.row]
    }
}

// MARK: extention helpers
extension DefaultForecastPresenter {

    private func load() {
        show(.spinner)
        useCase.fetchForecast { [weak self] (result) in
            switch result {
            case .success(let forecasts):
                var model = [(header: ForecastHeaderViewModel, cells: [ForecastCellViewModel])]()
                for forecast in forecasts {
                    guard let header = forecast.header,
                          let cell = forecast.cell
                    else { return }

                    if !model.contains(where: { $0.header == header }) {
                        model.append((header: header, cells: [cell]))
                    } else {
                        model[model.count - 1].cells.append(cell)
                    }
                }
                self?.model = model
                self?.show(.content)
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
}

// MARK: extention for converting to view model
fileprivate extension ForecastEntity {

    var header: ForecastHeaderViewModel? {
        guard let (date, _) = dayAndTime(date)
        else { return nil }
        return .init(date: date)
    }

    var cell: ForecastCellViewModel? {
        guard let (_, time) = dayAndTime(date)
        else { return nil }
        var entity = self
        entity.date = time
        return .init(entity: entity)
    }

    func dayAndTime(_ date: String) -> (String, String)? {

        let dayAndTime = date.split(separator: " ")
        guard dayAndTime.count == 2 else { return nil }

        guard let day = dayOfWeek(String(dayAndTime[0]))
        else { return nil }

        let time = String(dayAndTime[1].dropLast(3))
        return (day, time)
    }

    func dayOfWeek(_ day: String) -> String? {

        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: day) else { return nil }

        formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let weekDay = formatter.string(from: date)

        return weekDay
    }
}
