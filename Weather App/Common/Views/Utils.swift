//
//  Utils.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/8/21.
//

import UIKit

struct Utils {

    static func createSpinner(superview: UIView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor(named: "AccentColor")!
        superview.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 40),
            spinner.widthAnchor.constraint(equalTo: spinner.heightAnchor)
        ])
        return spinner
    }

    static func createErrorView(superview: UIView, delegate: ErrorViewDelegate) -> ErrorView {
        let errorView = ErrorView()
        errorView.delegate = delegate
        superview.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            errorView.heightAnchor.constraint(equalToConstant: 196),
            errorView.widthAnchor.constraint(equalTo: errorView.heightAnchor)
        ])
        return errorView
    }
}
