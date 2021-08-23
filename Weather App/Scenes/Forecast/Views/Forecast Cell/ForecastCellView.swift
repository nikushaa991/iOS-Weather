//
//  ForecastCellView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/8/21.
//

import UIKit

class ForecastCellView: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var forecastIconImageView: UIImageView!

    func configure(from model: ForecastCellViewModel) {
        backgroundColor = .clear
        selectionStyle = .none
        dateLabel.text = model.entity.date
        descriptionLabel.text = model.entity.description
        temperatureLabel.text = "\(model.entity.temperature)°C"
        forecastIconImageView.image = UIImage(data: model.entity.icon)
    }
}
