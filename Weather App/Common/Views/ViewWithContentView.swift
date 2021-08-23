//
//  ViewWithContentView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/6/21.
//

import UIKit

class ViewWithContentView: UIView {

    @IBOutlet weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {

        let className = String(describing: type(of: self))
        Bundle.main.loadNibNamed(className, owner: self, options: nil)

        guard let content = contentView else {
            fatalError("contentView not set")
        }

        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(content)
    }
}
