//
//  AddCityErrorView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import UIKit

class AddCityErrorView: ViewWithContentView {

    @IBOutlet weak var errorMessageLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        contentView.layer.cornerRadius = 24
    }

    func configure(with error: String) {
        errorMessageLabel.text = error
    }
}
