//
//  GradientView.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/6/21.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor: UIColor = .clear {
        didSet { updateView() }
    }

    @IBInspectable var endColor: UIColor = .clear {
        didSet { updateView() }
    }

    override class var layerClass: AnyClass {
        get { CAGradientLayer.self }
    }

    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
