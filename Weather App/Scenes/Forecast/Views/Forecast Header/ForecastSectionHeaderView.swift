//
//  ForecastSectionHeaderView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/8/21.
//

import UIKit

class ForecastSectionHeaderView: ViewWithContentView {

    @IBOutlet weak var sectionNameLabel: UILabel!

    func configure(from model: ForecastHeaderViewModel) {
        sectionNameLabel.text = model.date.uppercased()
    }
}
