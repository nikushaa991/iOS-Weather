//
//  TodayDetailView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import UIKit

class TodayDetailView: ViewWithContentView {

    @IBInspectable var icon: UIImage? = nil {
        willSet { iconImageView.image = newValue }
    }

    @IBInspectable var detail: String = "" {
        willSet { detailLabel.text = newValue }
    }

    @IBInspectable var value: String = "" {
        willSet { valueLabel.text = newValue }
    }

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func configure(from model: TodayDetailViewModel) {
        value = model.value
    }
}
