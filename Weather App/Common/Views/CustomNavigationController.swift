//
//  CustomNavigationController.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/6/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = .init()
        navigationBar.setBackgroundImage(.init(), for: .default)
        navigationBar.titleTextAttributes = navigationBar.titleTextAttributes ?? [:]
        navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] = UIColor.white
    }
}
