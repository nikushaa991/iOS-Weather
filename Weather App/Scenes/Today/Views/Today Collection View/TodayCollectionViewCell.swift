//
//  TodayCollectionViewCell.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/27/21.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    @IBOutlet weak var cloudinessDetailView: TodayDetailView!
    @IBOutlet weak var humidityDetailView: TodayDetailView!
    @IBOutlet weak var windSpeedDetailView: TodayDetailView!
    @IBOutlet weak var windDirectionDetailView: TodayDetailView!

    private static var backgroundColors: [[UIColor]] = [
        [UIColor(named: "blue-gradient-start")!, UIColor(named: "blue-gradient-end")!],
        [UIColor(named: "green-gradient-start")!, UIColor(named: "green-gradient-end")!],
        [UIColor(named: "ochre-gradient-start")!, UIColor(named: "ochre-gradient-end")!],
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 24
    }

    func configure(from viewModel: TodayViewModel) {
        configureBackgroundColor(from: viewModel.index)
        configure(from: viewModel.entity)
    }

    private func configureBackgroundColor(from index: Int) {
        let contentView = self.contentView as! GradientView
        let startEndColors = TodayCollectionViewCell.backgroundColors
        let colorIndex = index % startEndColors.count
        let startColor = startEndColors[colorIndex][0]
        let endColor = startEndColors[colorIndex][1]
        contentView.startColor = startColor
        contentView.endColor = endColor
    }

    private func configure(from entity: TodayEntity) {
        cityNameLabel.text = entity.city.cityName
        temperatureLabel.text = "\(entity.temperature)°C | \(entity.description)"
        cloudinessDetailView.configure(from: .init(value: "\(entity.cloudiness) %"))
        humidityDetailView.configure(from: .init(value: "\(entity.humidity) mm"))
        windSpeedDetailView.configure(from: .init(value: "\(entity.windSpeed) km/h"))
        windDirectionDetailView.configure(from: .init(value: "\(entity.windDirection)°"))
    }
}
