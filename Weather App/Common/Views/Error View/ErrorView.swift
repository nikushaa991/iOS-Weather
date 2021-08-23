//
//  ErrorView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import UIKit

class ErrorView: ViewWithContentView {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!

    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        reloadButton.layer.cornerRadius = 8
    }

    @IBAction func reloadTapped() {
        delegate?.reloadTapped()
    }

    func configure(with error: String) {
        errorLabel.text = error
    }
}

protocol ErrorViewDelegate: class {
    func reloadTapped()
}
